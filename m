Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161453AbWBUKUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbWBUKUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161457AbWBUKUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:20:21 -0500
Received: from mail.gmx.de ([213.165.64.20]:60311 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161453AbWBUKUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:20:19 -0500
X-Authenticated: #428038
Date: Tue, 21 Feb 2006 11:20:16 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060221102016.GB19643@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <200602192053.25767.dhazelton@enter.net> <43F9F11E.nail5BM21M01Q@burner> <200602201340.30484.dhazelton@enter.net> <43FAE6A6.nailD1261QRW3@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FAE6A6.nailD1261QRW3@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-21:

> There used to be generic support, so this way of support is unneeded.

It is not your business to decide what is unneeded in Linux and what
isn't, and CD writing (still the Subject line!) doesn't require
ide-scsi. Evidently the additional SG_IO support in ide-cd doesn't break
your applications.

-- 
Matthias Andree
