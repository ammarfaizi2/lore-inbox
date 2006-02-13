Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWBMNwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWBMNwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWBMNwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:52:44 -0500
Received: from mail.gmx.de ([213.165.64.21]:52677 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751767AbWBMNwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:52:43 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 14:52:40 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213135240.GD10566@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060208162828.GA17534@voodoo> <200602090757.13767.dhazelton@enter.net> <43EC8F22.nailISDL17DJF@burner> <200602092221.56942.dhazelton@enter.net> <43F08C5F.nailKUSDKZUAZ@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F08C5F.nailKUSDKZUAZ@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-13:


> Then please try to inform yourself in order to understand that you are wrong.

No, it is _you_ and nobody else who refuses information.

> For this reason, it is bejond the scope of the Linux kernel team to decide on 
> this abstraction layer. The Linux kernel team just need to take the current
> libscg interface as given as _this_  _is_ the way to do best abstraction.

This is ridiculous. The abstraction (SG_IO on an open special file) is
in the kernel. Feel free to stack as many layers on top as you wish, but
the kernel isn't going to bend just to support a random abstraction
library that cannot achieve its goals in its current form anyways.

-- 
Matthias Andree
