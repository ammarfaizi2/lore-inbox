Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbUKKVs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbUKKVs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUKKVrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:47:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1285 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262371AbUKKVq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:46:26 -0500
Date: Thu, 11 Nov 2004 22:45:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Reiser{3,4}: problem with the copyright statement
Message-ID: <20041111214554.GB2310@stusta.de>
References: <20041111012333.1b529478.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

both the reiser3 and reiser4 copyright statements contain:

<--  snip  -->

Reiser4 is hereby licensed under the GNU General
Public License version 2.

Source code files that contain the phrase "licensing governed by
reiser4/README" are "governed files" throughout this file.  Governed
files are licensed under the GPL.  The portions of them owned by Hans
Reiser, or authorized to be licensed by him, have been in the past,
and likely will be in the future, licensed to other parties under
other licenses.  If you add your code to governed files, and don't
want it to be owned by Hans Reiser, put your copyright label on that
code so the poor blight and his customers can keep things straight.
All portions of governed files not labeled otherwise are owned by Hans
Reiser, and by adding your code to it, widely distributing it to
others or sending us a patch, and leaving the sentence in stating that
licensing is governed by the statement in this file, you accept this.
...

<--  snip  -->


I have no problem with dual-licensed code, but I do strongly dislike 
having this "unlike you explicitley state otherwise, you transfer all 
rights to Hans Reiser" in the kernel.

Besides the fact that giving the copyright completely away is nothing 
that is legally possible in at least Germany, I'm not happy with having 
to check every single file in the source tree for additional licence 
clauses before editing it - and then to consider whether my contribution 
might deserve a copyright label according to my local law.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

