Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278663AbRJXQwr>; Wed, 24 Oct 2001 12:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278664AbRJXQwh>; Wed, 24 Oct 2001 12:52:37 -0400
Received: from AMontpellier-201-1-4-3.abo.wanadoo.fr ([217.128.205.3]:7694
	"EHLO awak") by vger.kernel.org with ESMTP id <S278663AbRJXQw2> convert rfc822-to-8bit;
	Wed, 24 Oct 2001 12:52:28 -0400
Subject: Re: [RFC] New Driver Model for 2.5
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
In-Reply-To: <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.99+cvs.2001.10.22.19.14 (Preview Release)
Date: 24 Oct 2001 18:46:48 +0200
Message-Id: <1003942008.9892.100.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le mer 24-10-2001 à 18:15, Linus Torvalds a écrit :
> Also, realize that the act of suspension is STARTED BY THE USER. Which

... or triggered by some kind of inactivity timer, or low battery
condition.

	Xav

