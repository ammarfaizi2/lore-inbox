Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291806AbSBTMPk>; Wed, 20 Feb 2002 07:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291812AbSBTMPa>; Wed, 20 Feb 2002 07:15:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37636 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291806AbSBTMPQ>;
	Wed, 20 Feb 2002 07:15:16 -0500
Message-ID: <3C739351.20C03FDA@mandrakesoft.com>
Date: Wed, 20 Feb 2002 07:15:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org,
        khc@pm.waw.pl, davem@redhat.com
Subject: Re: [PATCH] HDLC patch for 2.5.5 (0/3)
In-Reply-To: <Pine.LNX.4.33.0202191732320.1443-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 17 Feb 2002, Jeff Garzik wrote:
> > Francois Romieu wrote:
> > > [0/3]:
> > > - SIOCDEVICE -> SIOCWANDEV conversion
> > > - hdlc_proto -> raw_hdlc_proto
> >
> > patch looks ok to me.
> 
> Jeff, are yu willing to merge these things?

Sure.

FWIW it looks like Krzysztof Halasa has some good points, so a "[BK
PATCH]" may be delayed a day or two before coming to you, I'm betting...

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
