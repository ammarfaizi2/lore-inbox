Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136230AbRDVR2R>; Sun, 22 Apr 2001 13:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136231AbRDVR2H>; Sun, 22 Apr 2001 13:28:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8978 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S136230AbRDVR2B>;
	Sun, 22 Apr 2001 13:28:01 -0400
Message-ID: <3AE31470.A6F82F52@linux-m68k.org>
Date: Sun, 22 Apr 2001 19:27:12 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@linuxcare.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
        Philip Blundell <philb@gnu.org>, junio@siamese.dhis.twinsun.com,
        Manuel McLure <manuel@mclure.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rJw2-0005r5-00@the-village.bc.nu> <d366fw29sv.fsf@lxplus015.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jes Sorensen wrote:

> In principle you just need 2.7.2.3 for m68k, but someone decided to
> raise the bar for all architectures by putting a check in a common
> header file.

IIRC 2.7.2.3 has problems with labeled initializers for structures,
which makes 2.7.2.3 unusable for all archs under 2.4.

bye, Roman
