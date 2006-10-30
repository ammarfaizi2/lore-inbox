Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbWJ3Txe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbWJ3Txe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965454AbWJ3Txe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:53:34 -0500
Received: from brick.kernel.dk ([62.242.22.158]:3662 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965399AbWJ3Txd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:53:33 -0500
Date: Mon, 30 Oct 2006 20:55:13 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Daniel Drake <ddrake@brontes3d.com>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: splice blocks indefinitely when len > 64k?
Message-ID: <20061030195512.GP14055@kernel.dk>
References: <1162226390.7280.18.camel@systems03.lan.brontes3d.com> <45464E67.7030004@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45464E67.7030004@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't top post, please.

On Mon, Oct 30 2006, Phillip Susi wrote:
> While it should not simply hang, the splice size needs to be an even 
> multiple of the page size.

No, that is incorrect.

-- 
Jens Axboe

