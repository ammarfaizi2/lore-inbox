Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbSJ0KLf>; Sun, 27 Oct 2002 05:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbSJ0KLf>; Sun, 27 Oct 2002 05:11:35 -0500
Received: from users.linvision.com ([62.58.92.114]:31639 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262334AbSJ0KLe>; Sun, 27 Oct 2002 05:11:34 -0500
Date: Sun, 27 Oct 2002 11:17:51 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
Message-ID: <20021027111751.B27535@bitwizard.nl>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk> <ap97nr$h6e$1@forge.intermeta.de> <1035479086.9935.6.camel@gby.benyossef.com> <1035539042.23977.24.camel@forge> <apcaub$ov5$1@cesium.transmeta.com> <apdrkh$h8n$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apdrkh$h8n$1@forge.intermeta.de>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 10:43:29AM +0000, Henning P. Schmiedehausen wrote:
> But my point is, that these beasts normally don't run a general
> purpose operating system and that they're much less prone to buffer
> overflow or similar attacks, simply because they don't use popular
> software with known bugs (e.g.  OpenSSL) or these functions (like
> doing crypto) are in hardware.

The script kiddies simply haven't bothered to attack these boxes yet. 
When they are done with the bugs in the common oses, they will move on
to other targets...

And you say that a "root shell" on the box doesn't give you root on
the application server? It might be too hard for a "worm" but it will
be easy for a human. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
