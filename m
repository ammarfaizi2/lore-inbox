Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSBSSab>; Tue, 19 Feb 2002 13:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSBSS36>; Tue, 19 Feb 2002 13:29:58 -0500
Received: from web21308.mail.yahoo.com ([216.136.128.174]:35638 "HELO
	web21308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S286692AbSBSS2h>; Tue, 19 Feb 2002 13:28:37 -0500
Message-ID: <20020219182754.68142.qmail@web21308.mail.yahoo.com>
Date: Tue, 19 Feb 2002 10:27:54 -0800 (PST)
From: chiranjeevi vaka <cvaka_kernel@yahoo.com>
Subject: kernel panic
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am working on linux kernel tcp/ip optimization.
After doing some changes in my kernel, I am copiling
the kernel. While doing make xconfig, I have seleceted
some of known options and later as usual I have done
make dep;make bzdisk. 

The problem is while booting the kernel with my newly
developed floppy, I am getting the error message

kernel panic: VFS: Unable to mount root fs on 08:03

I donno what to do. Is it some thing related to "make
xconfig" options or some other thing. Please give me
suggestion.

Thanking you in advance
Murali.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
