Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSCSV3W>; Tue, 19 Mar 2002 16:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292870AbSCSV3M>; Tue, 19 Mar 2002 16:29:12 -0500
Received: from web20509.mail.yahoo.com ([216.136.226.144]:24923 "HELO
	web20509.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292857AbSCSV3E>; Tue, 19 Mar 2002 16:29:04 -0500
Message-ID: <20020319212903.93414.qmail@web20509.mail.yahoo.com>
Date: Tue, 19 Mar 2002 22:29:03 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux 2.4.19pre3-ac2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jdthood@mail.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16nPoY-0000Aw-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>EIP; 0000879a Before first symbol   <=====
> 
> In the BIOS 

in fact, you're right. At home, I don't have
this problem on any of my computers (nearly
all have an award bios). One of the two
victims at work was a compaq with a compaq
bios, while a friend's compaq notebook
(armada e500) is unaffected. All tested
hosts have either a 0e or a PNP0f13 entry.

I will dump the bios tomorrow, but I don't
know how pnpbios works (I presume it uses
some protected mode functions of int 15,
but I may be completely wrong). I will
have a great day reading the sources.

Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
