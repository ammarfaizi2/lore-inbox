Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268072AbRG2Q0R>; Sun, 29 Jul 2001 12:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268078AbRG2Q0H>; Sun, 29 Jul 2001 12:26:07 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:17158 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268072AbRG2QZ4>;
	Sun, 29 Jul 2001 12:25:56 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107291625.UAA16491@ms2.inr.ac.ru>
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
To: thiemo@sics.se (Thiemo Voigt)
Date: Sun, 29 Jul 2001 20:25:35 +0400 (MSK DST)
Cc: samudrala@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        lartc@mailman.ds9a.nl, diffserv-general@lists.sourceforge.net,
        rusty@rustcorp.com.au
In-Reply-To: <3B631A00.8E860DC1@sics.se> from "Thiemo Voigt" at Jul 28, 1 10:01:04 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> The aim of TCP SYN policing is to prevent server overload by discarding
> connection requests

Well, I alluded to this particularly. :-)

But if Sridhar meaned this saying about SYN policing, I would
prefer this, rather than bare prioritization, which is pretty
dubious when taken alone.

Alexey
