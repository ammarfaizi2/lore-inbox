Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263929AbRFHI0t>; Fri, 8 Jun 2001 04:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263931AbRFHI0k>; Fri, 8 Jun 2001 04:26:40 -0400
Received: from web10404.mail.yahoo.com ([216.136.130.96]:63752 "HELO
	web10404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263929AbRFHI0Z>; Fri, 8 Jun 2001 04:26:25 -0400
Message-ID: <20010608082621.71437.qmail@web10404.mail.yahoo.com>
Date: Fri, 8 Jun 2001 18:26:21 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.2.20 pre2 compilation broken
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E15848C-0001gX-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry :-), I apply the reiserfs patch from namesys.com

Anyway it is because the reiserfs code and gcc 2.96 in
Mandrake. It is ok using gcc 2.95.3 downward.
Suprisingly gcc 2.96 compile 2.4.x without any problem
at least to me.


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote: > >
fs/filesystems.a(reiserfs.o): In function
> > `ip_check_balance':
> > reiserfs.o(.text+0x9dde): undefined reference to
> 
> This isnt Linux 2.2. Linux 2.2 does not include
reiserfs.


=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
