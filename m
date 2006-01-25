Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWAYKC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWAYKC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 05:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWAYKC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 05:02:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50538 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751098AbWAYKC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 05:02:28 -0500
Date: Wed, 25 Jan 2006 11:03:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Tetsuo Takata <takatan.linux@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]scsi:removal of the variable "ordered_flush"
Message-ID: <20060125100354.GE4212@suse.de>
References: <8e8498350601250159w126f0f37k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e8498350601250159w126f0f37k@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Tetsuo Takata wrote:
> Hi,
> 
> 
> After the recent overhaul of the block layer the variable
> "ordered_flush" is no longer used.

Indeed, good spotting! Applied. In the future, please make your patches
self contained wrt description.


-- 
Jens Axboe

