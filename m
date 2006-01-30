Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWA3SMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWA3SMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWA3SMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:12:32 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:4870 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751264AbWA3SMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:12:31 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
 library
References: <6403.1138392470@warthog.cambridge.redhat.com>
	<20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	<20060128104611.GA4348@hardeman.nu>
	<1138466271.8770.77.camel@lade.trondhjem.org>
	<20060128165732.GA8633@hardeman.nu>
	<1138504829.8770.125.camel@lade.trondhjem.org>
	<20060129113320.GA21386@hardeman.nu> <20060129122901.GX3777@stusta.de>
	<20060129131815.GB21386@hardeman.nu> <20060129233621.GB3777@stusta.de>
From: Nix <nix@esperi.org.uk>
X-Emacs: because one operating system isn't enough.
Date: Mon, 30 Jan 2006 18:09:40 +0000
In-Reply-To: <20060129233621.GB3777@stusta.de> (Adrian Bunk's message of "29
 Jan 2006 23:37:08 -0000")
Message-ID: <87acddvb8b.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jan 2006, Adrian Bunk uttered the following:
> Signed modules and/or binaries seems to be the application this might be 
> required for, so let's discuss exactly this application and not the 
> others.

Indeed. See e.g. the digsig project at <http://disec.sf.net/> for a
working implementation of signed binaries and shared libraries, with MPI
in the module for exactly this purpose.

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
