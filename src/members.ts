import arrayToTree from 'array-to-tree';
import membersData from './members.json';

const membersTree = {
  name: '成员',
  login: 'frontend9',
  value: 'frontend9',
  children: arrayToTree(
    membersData.map(
      ([id, login, nickname, parentId, joinDate, city, company]) => ({
        id,
        nickname,
        login,
        parentId: parentId === '00000' ? null : parentId,
        joinDate,
        city,
        company,
        name: nickname + '(' + id + ')',
        value: login,
      })
    ),
    {
      parentProperty: 'parentId',
      customID: 'id',
    }
  ),
};

export default membersTree;
