Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278604AbRJXQ5h>; Wed, 24 Oct 2001 12:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRJXQ51>; Wed, 24 Oct 2001 12:57:27 -0400
Received: from air-1.osdl.org ([65.201.151.5]:39948 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S278604AbRJXQ5N>;
	Wed, 24 Oct 2001 12:57:13 -0400
Date: Wed, 24 Oct 2001 09:54:49 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <1003942008.9892.100.camel@nomade>
Message-ID: <Pine.LNX.4.33.0110240954120.9849-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24 Oct 2001, Xavier Bestel wrote:

> le mer 24-10-2001 à 18:15, Linus Torvalds a écrit :
> > Also, realize that the act of suspension is STARTED BY THE USER. Which
>
> ... or triggered by some kind of inactivity timer, or low battery
> condition.

...which should be done in userspace.

	-pat

