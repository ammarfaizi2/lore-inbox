Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTA0U1P>; Mon, 27 Jan 2003 15:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbTA0U1P>; Mon, 27 Jan 2003 15:27:15 -0500
Received: from havoc.daloft.com ([64.213.145.173]:56266 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S263039AbTA0U1P>;
	Mon, 27 Jan 2003 15:27:15 -0500
Date: Mon, 27 Jan 2003 15:36:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Edward Tandi <ed@efix.biz>
Cc: Jens Axboe <axboe@suse.de>, Martin MOKREJ? <mmokrejs@natur.cuni.cz>,
       Ross Biro <rossb@google.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030127203628.GA20873@gtf.org>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz> <3E356403.9010805@google.com> <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz> <20030127192327.GD889@suse.de> <1043699262.2696.7.camel@wires.home.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043699262.2696.7.camel@wires.home.biz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 08:27:43PM +0000, Edward Tandi wrote:
> The VIA audio issue is still there though ;-)

What issue?

Alan has patches that should address support for VT8233 in
via82cxxx_audio driver, in this -ac kernel.

	Jeff



