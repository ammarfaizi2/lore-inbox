Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWATI0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWATI0q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWATI0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:26:45 -0500
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:28652 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1750723AbWATI0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:26:45 -0500
Date: Fri, 20 Jan 2006 09:25:50 +0100
From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal,
 a slightly different approach
In-reply-to: <m3ek34vucz.fsf@defiant.localdomain>
X-Originating-IP: 213.238.46.206
To: Krzysztof Halasa <khc@pm.waw.pl>, Martin Langer <martin-langer@gmx.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Message-id: <1137745550.43d09e8ebde13@webmail.uni-halle.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
References: <20060119174600.GT19398@stusta.de>
 <m3ek34vucz.fsf@defiant.localdomain>
X-Scan-Signature: 6cb34d70a4ee32cac1889b569d577157
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:

> Adrian Bunk <bunk@stusta.de> writes:
>
> > 3. no ALSA drivers for the same hardware
> >
> > SOUND_ACI_MIXER
>
> Never heard

A chip used on miroPCM (ISA) cards.  An ALSA driver has been written for it,
and it seems the ACI stuff is supported.  (This driver is not yet in the
kernel tree.)

Martin, has your miro.c a complete implementation of what is in aci.c?


Clemens
