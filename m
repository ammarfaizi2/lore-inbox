Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132077AbRCYQ23>; Sun, 25 Mar 2001 11:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132084AbRCYQ2U>; Sun, 25 Mar 2001 11:28:20 -0500
Received: from mailsrv.rollanet.org ([192.55.114.7]:37669 "HELO
	mx.rollanet.org") by vger.kernel.org with SMTP id <S132077AbRCYQ2K>;
	Sun, 25 Mar 2001 11:28:10 -0500
Message-ID: <3ABE1C70.92CBBF01@umr.edu>
Date: Sun, 25 Mar 2001 10:27:28 -0600
From: Nathan Neulinger <nneul@umr.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Non keyboard trigger of Alt-SysRQ-S-U-B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way that this can be triggered remotely? I frequently get
into situations with a particular machine where 'reboot' or 'reboot -f'
just plain won't work, and would like to be able do a 'filesystem clean'
forcible reboot, but don't particularly care about services being shut
down cleanly. Of course, the key is, I'm not at the keyboard of the
server in question.

I figured there may be some way to have a module do this, but if anyone
has any ideas, I'd appreciate it. I did see the example sent not too
long ago about triggering a panic, but that won't cleanly unmount the
filesystems. 

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
CIS - Systems Programming                Fax: (573) 341-4216
