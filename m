Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279581AbRJ2WcL>; Mon, 29 Oct 2001 17:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279582AbRJ2WcB>; Mon, 29 Oct 2001 17:32:01 -0500
Received: from web20509.mail.yahoo.com ([216.136.226.144]:42713 "HELO
	web20509.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279581AbRJ2Wby>; Mon, 29 Oct 2001 17:31:54 -0500
Message-ID: <20011029223230.69111.qmail@web20509.mail.yahoo.com>
Date: Mon, 29 Oct 2001 23:32:30 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Ethernet NIC dual homing
To: Laurent Deniel <deniel@worldnet.fr>
Cc: linux-kernel@vger.kernel.org, ctindel@users.sourceforge.net
In-Reply-To: <3BDDD55C.56EDE4E0@worldnet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, it seems that a lot of good stuff (e.g. ARP
> monitoring and
> SIOCBONDCHANGEACTIVE ioctl) are implemented in the
> bonding patch for 2.4.13.
> Will it be included in the mainstream 2.4.x kernel
> or is it a 2.5 thing ? 

Personnaly, I don't know. Chad now maintains the
project so he may have better opinions about this.
But I'd like to see it in the 2.4 once well tested
since it interests lots of people, and it allows us to
put linux boxes in more critical environments.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
