Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281225AbRKPHxz>; Fri, 16 Nov 2001 02:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281228AbRKPHxq>; Fri, 16 Nov 2001 02:53:46 -0500
Received: from arthur.runestig.com ([62.108.199.166]:5636 "EHLO
	arthur.runestig.com") by vger.kernel.org with ESMTP
	id <S281225AbRKPHxh>; Fri, 16 Nov 2001 02:53:37 -0500
Message-ID: <006a01c16e73$3fc1e290$64110b0a@datavis.se>
From: "Peter 'Luna' Runestig" <peter@runestig.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <016a01c16e14$3a937c70$1901a8c0@node0.idium.eu.org> <E164TX4-0007i6-00@trillium-hollow.org> <20011115131600.C5306@furble> <20011115152504.A16907@qcc.sk.ca>
Subject: Re: Microsoft IE6 is crashing with Linux 2.4.X
Date: Fri, 16 Nov 2001 08:49:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Charles Cazabon" <linux-kernel@discworld.dyndns.org>:
> Gordon Oliver <gordo@pincoya.com> wrote:
> >
> > > > > The connection to the server has failed. Account:
> > > > > 'mail.timpanogas.org', Server: 'mail.timpanogas.org', Protocol:
> > > > > SMTP, Port: 25, Secure(SSL): No, Socket Error: 10061, Error
> > > > > Number: 0x800CCC0E
>
> > you may also note that IE6 is making an SSL SMTP connection "smtps" on
> > port 25,
>
> No, it isn't.  "Secure(SSL): No" is pretty self-explanatory.

Even if it where "Secure(SSL): Yes" it would still be OK, IE is using the
STARTTLS command to initiate SSL connection to the SMTP server (if it
supports it). Using special "SSL-ports" has been depreciated for quite a
while now.

Cheers,
Peter
----------------------------------------------------------------
Peter 'Luna' Runestig (fd. Altberg), Sweden <peter@runestig.com>
PGP Key ID: 0xD07BBE13
Fingerprint: 7B5C 1F48 2997 C061 DE4B  42EA CB99 A35C D07B BE13
AOL Instant Messenger Screenname: PRunestig


