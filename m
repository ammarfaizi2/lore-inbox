Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264564AbRFMHMk>; Wed, 13 Jun 2001 03:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264565AbRFMHMa>; Wed, 13 Jun 2001 03:12:30 -0400
Received: from [203.197.249.146] ([203.197.249.146]:37356 "EHLO
	indica.wipsys.stph.net") by vger.kernel.org with ESMTP
	id <S264564AbRFMHMW>; Wed, 13 Jun 2001 03:12:22 -0400
From: "Srinivas Surabhi" <srinivas.surabhi@wipro.com>
To: linux-kernel@vger.kernel.org
Message-ID: <3495d3383d.3383d3495d@wipro.com>
Date: Wed, 13 Jun 2001 12:10:06 +0500
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: proc inode
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everybody,

   when i tried to read the inode of proc file/directory
using a  pointer to dirent which is returned by the readdir().,
i am getting a different inode number(32449)instead of which
 is shown as inode 2 when ls -ia is done.

 hope it is clear.. 

  thanks for all who tried to clarify my doubt..

srinivas

 

