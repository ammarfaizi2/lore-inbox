Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWAJTZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWAJTZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWAJTZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:25:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61201 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932293AbWAJTZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:25:22 -0500
Date: Tue, 10 Jan 2006 20:27:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060110192708.GZ3389@suse.de>
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C40803.2000106@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Mark Lord wrote:
> Okay, fixed the ordering of the "default" lines
> so that the Kconfig actually works correctly.
> 
> Best for Andrew to soak this one in -mm.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>

Signed-off-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

