Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263480AbRFFPnh>; Wed, 6 Jun 2001 11:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263501AbRFFPn1>; Wed, 6 Jun 2001 11:43:27 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:5207 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S263480AbRFFPnJ>; Wed, 6 Jun 2001 11:43:09 -0400
Message-ID: <000701c0ee9f$515fd6a0$3303a8c0@einstein>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com><991815578.30689.1.camel@nomade><20010606095431.C15199@dev.sportingbet.com><0106061316300A.00553@starship> <200106061528.f56FSKa14465@vindaloo.ras.ucalgary.ca>
Subject: Re: Break 2.4 VM in five easy steps
Date: Wed, 6 Jun 2001 17:42:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Linus said if I use swap it should be at least twice as much as RAM.
there will be much more discussion about it, for me this contraint is a very
very bad idea.

Have you ever thought about diskless workstations? Swapping over a network
sounds ugly.

Nevertheless, my question is:
what happens if I plan to use no swap. I  have enough memory installed for
my purposes and every swapping operation can do only one thing: slowing down
the system.
Is there a different behaviour if I completely disable swap?

greetings

Christian Bornträger

