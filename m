Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVASULs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVASULs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVASULs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:11:48 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:35491 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261783AbVASULr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:11:47 -0500
Date: Wed, 19 Jan 2005 21:11:45 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
Message-ID: <20050119201145.GA10279@janus>
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org> <20050118080214.GB8747@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118080214.GB8747@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 09:02:14AM +0100, Andries Brouwer wrote:
> 
> Suppose we have kernel command line options
> 	rootdev=, rootpttype=, root=, rootfstype=, rootwait=
> telling the kernel what device is the root device,
> what type of partition table it has,
> on which partition the root filesystem lives,
> what type of filesystem it has,

might as well add rootuuid= for those fs which support it.

-- 
Frank
