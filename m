Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVAWTiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVAWTiC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 14:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVAWTiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 14:38:01 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:59662 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261344AbVAWThy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 14:37:54 -0500
From: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Organization: None
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: System beeper - no sound from mobo's own speaker
Date: Sun, 23 Jan 2005 19:37:53 +0000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501231937.53099.stephen@g6dzj.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I seem to have a problem that, in that when I am using the kernel supplied 
with Mandrake 10.0 and 10.1 and also fedora 3, there seems to be a distinct 
lack of beeps coming from the system, once it is up and running. I am NOT 
talking about sounds that might be coming from any sound card that might be 
connected to the system, but the plain old speaker that sits in the PC case.

This, to my mind, is not very usefull for a server or a laptop that might 
generate system beeps, ie inserting a wifi card for instance on a laptop.

As I'm running Mandrake I have posted this to them, but as of yet I have had 
no responce or reaction. I did do a search and I found at least one user of 
Redhat reporting the same sort of problem, so I am guessing that it's not a 
problem that is of Mandrakes doing, ie they forgot to include it in the 
kernel that they bult for their distribution.

I have installed the latest kernel from fedora 2.6.10, but that didn't change 
things.

Please let me know if I have posted something that is a known problem, and 
I'll shut up and wait for a new kernel to be release that has this fixed. I 
cannot beleive that this has been missed in testing, but at the same time I 
have no beeps at all from any of the 3 machines that I have tested and it has 
been reported to me, by a friend that is running Mandrake 10.1, he is running 
different hardware, and can confirm that it was working before the upgrade. 
The only common thing before we changed as that we were both running 2.4 
kernels.

I can supply details of hardware if wanted.

-- 
                 O  o
            _\_   o
         \\/  o\ .
         //\___=
            ''
Sun, 23 Jan 2005 18:58:38 +0000
 18:58:38 up  9:13,  0 users,  load average: 1.30, 1.15, 1.05
Basic Definitions of Science:
	If it's green or wiggles, it's biology.
	If it stinks, it's chemistry.
	If it doesn't work, it's physics.
