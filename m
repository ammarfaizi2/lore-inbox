Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272850AbTG3MMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272851AbTG3MMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:12:45 -0400
Received: from mx.laposte.net ([213.30.181.11]:35625 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S272850AbTG3MMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:12:43 -0400
Message-ID: <001101c35693$8e97cc40$0a00a8c0@toumi>
From: "Ghozlane Toumi" <gtoumi@laposte.net>
To: "Jamey Hicks" <jamey.hicks@hp.com>, "Pavel Machek" <pavel@ucw.cz>
Cc: "Philip Graham Willoughby" <pgw99@doc.ic.ac.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk> <20030729180005.GD2601@openzaurus.ucw.cz> <1059565549.27394.9.camel@vimes.crl.hpl.hp.com>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystemever
Date: Wed, 30 Jul 2003 14:06:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You wrote:

> On Tue, 2003-07-29 at 14:00, Pavel Machek wrote:
> > Hi!
> >
> > I'd not said this is so pointless... handhelds tend to have "new mail"
led for example.
> > Better question is why it is not integrated with input subsystem
(similar to kbd leds).
>
> I would have thought that leds are output?  Why would output devices be
> integrated into the input subsystem?

Perhaps because the input subsystem could/should be renamed to event
subsytem ?

ghoz

