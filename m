Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbRDKP2E>; Wed, 11 Apr 2001 11:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRDKP1x>; Wed, 11 Apr 2001 11:27:53 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:1043 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S132607AbRDKP1m>; Wed, 11 Apr 2001 11:27:42 -0400
To: Ulrich.Lauther@mchp.siemens.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 bug in handling vfat?
In-Reply-To: <200104102022.f3AKM8Q03806@emma.mchp.siemens.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 12 Apr 2001 00:27:23 +0900
In-Reply-To: <200104102022.f3AKM8Q03806@emma.mchp.siemens.de>
Message-ID: <87d7ajzcbo.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.102
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

I think that it is the bug of FAT-fs.
Please try the following patch.

Thanks
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=fat-2.4.3.diff.gz
Content-Transfer-Encoding: base64

H4sICDZ21DoAA2ZhdC0yLjQuMy5kaWZmAIWNQWuDMACFz+ZXvMtAG6MxtummFdw/GGywo0iNa6Da
YiKr/fWL68H1MJpLwvve99LotgUbhzccdT9emIjWURqdBv0VtyZuaxt32uyj/V98Twhj7IHsfaoG
7+oMSHCZ8W0mXiA454RS+v+y93EY8XoekAhwniVOe561hJQlWLrh4RZ0viTKksDTvUVTT+Gk6iHs
j9X87k69PeQEDo+9vrjMKrACZjKVvUb2WnXue6vMtzJ2JXlOmKdb+AtvjLW6UwEWnxZIJee32dVM
UcBf+BMkD2JBfX8JYxfdAHY7bALqVLhz15lX55ZY/7aSJMjJD1vXZKiiAQAA
--=-=-=--

