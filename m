Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUATN4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbUATN4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:56:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54763 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265287AbUATN4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:56:10 -0500
Date: Tue, 20 Jan 2004 14:56:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for ide-scsi crash
Message-ID: <20040120135608.GK2734@suse.de>
References: <UTC200401200944.i0K9iRE25868.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0401201302470.1014-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401201302470.1014-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20 2004, Pascal Schmidt wrote:
> On Tue, 20 Jan 2004 Andries.Brouwer@cwi.nl wrote:
> 
> > And then there is the read-only part that must be removed.
> 
> Not a problem for ide-cd, it already supports writing for DVD-RAM,
> and in -mm also packet writing.

Packet writing isn't in -mm, it's mt rainier writing.

-- 
Jens Axboe

