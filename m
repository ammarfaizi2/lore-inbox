Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280061AbRKEAEL>; Sun, 4 Nov 2001 19:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280060AbRKEAEB>; Sun, 4 Nov 2001 19:04:01 -0500
Received: from a904j637.tower.wayne.edu ([141.217.140.65]:16885 "HELO
	stellar.outstep.com") by vger.kernel.org with SMTP
	id <S278770AbRKEADx>; Sun, 4 Nov 2001 19:03:53 -0500
Message-ID: <3BE5D6EC.8040204@outstep.com>
Date: Sun, 04 Nov 2001 19:01:48 -0500
From: Lonnie Cumberland <lonnie@outstep.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-20mdk i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Special Kernel Modification
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am new to this list and am very interested in any help that you might 
be able to give me for a particular Linux project that I am working on.

I am currently using a Pentium III 500Mhz running Mandrake 8.0 Linux and 
Kernel 2.4.3 as a development system.

The basic problem that I am running into is that I am working on an 
Internet related project and thus need to ensure various types of 
document security for the eventual users of this system, if things go well.

I have look into using things like "chroot" to restrict the users for 
this very special server, but that solution is not what we need.

I am building a special xserver that will allow users to login and then 
the xserver will run a single application such as StarOffice. When the 
user exits from the application then the Xserver will log them out.

My problem is that I need to find a way to prevent the user from 
navigating out of their home directories.

I have also looking the possiblility of writing my own filesystem, but I 
am told that this needs to be done at the VFS level.

Is there someone who might be able to give me some information on how I 
could add a few lines to the VFS filesystem so that I might set some 
type of extended attribute to prevent users from navigating out of the 
locations.

Any help would be greatly appreciated,
Lonnie Cumberland

