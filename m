Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbTDBC1D>; Tue, 1 Apr 2003 21:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbTDBC1D>; Tue, 1 Apr 2003 21:27:03 -0500
Received: from smtp2.acsu.buffalo.edu ([128.205.6.85]:57742 "HELO
	smtp2.acsu.buffalo.edu") by vger.kernel.org with SMTP
	id <S261340AbTDBC1C>; Tue, 1 Apr 2003 21:27:02 -0500
Date: Tue, 01 Apr 2003 21:38:31 -0500
From: Linus Torvalds <tordalds@transmeta.com>
To: linux-kernel@vger.kernel.org
Subject: A more balanced view of user priviliges
Message-ID: <503755781.1049233111@resnet146-209.resnet.buffalo.edu>
Originator-Info: login-id=nrussell; server=imap.buffalo.edu
X-Mailer: Mulberry/2.2.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've always tried to keep our work separate from religious and political 
influences, however I also feel that incorporating suggestions from all 
categories of users is part of what makes Linux, and Open Source in 
general, so great.

I was recently talking with a friend of mine who is a Lirpa Buddhist (of 
the Lo'of school, to be specific).  He said that as it currently stands, we 
have two types of user - the superuser, with absolute power over the 
system, and the ordinary user, with no power.  We even occasionally refer 
to systems administrators as God.  My Lipran friend believes that this 
reflects an excessively Western thinking about the relationship between man 
and God - a thinking which is so embedded in our culture that we seldom 
realize it.  After some discussion with him, I have decided that as of 
2.7.x we will fork the kernel to allow other ideas about priviledges.  In 
particular, there will be a "Lipraite" version of the Kernel in which there 
are seven categories of users:

1. The Creative User - can create any file but must then stand back and not 
modify it;

2. The Destructive User - can delete any file, or shut the system down, at 
which time (once hardware support is in place) it will rise from its own 
ashes

3. The Force of Maintence - can change the system within fundamental 
physical laws.  Can not, for example, load new device drivers.

4. Ordinary users, who are bound to the cycle of writing, compiling, and 
debugging, until they achieve Nirvana and log out of the system.

More may be added as needed.

Hopefully with these changes Linux 2.7+ will be more friendly to a diverse 
user population.

Linus
