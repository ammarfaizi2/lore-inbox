Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRCXA1H>; Fri, 23 Mar 2001 19:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131354AbRCXA05>; Fri, 23 Mar 2001 19:26:57 -0500
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:60168 "EHLO
	ma-northadams1-47.nad.adelphia.net") by vger.kernel.org with ESMTP
	id <S131248AbRCXA0o>; Fri, 23 Mar 2001 19:26:44 -0500
Date: Fri, 23 Mar 2001 19:25:51 -0500
From: Eric Buddington <eric@ma-northadams1-47.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: ext2 corruption in 2.4.2-ac20
Message-ID: <20010323192551.G24693@ma-northadams1-47.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using 2.4.0-ac20 for about a week, and today suddenly got a slew of messages:

EXT2-fs error (device ide0(3,1)): ext2_new_block: Free blocks count corrupted for block group 43

while copying the mozilla tree (a great way to stress out a filesystem! :)). This is the first such
problem I have had.

-Eric


