Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSKBV2v>; Sat, 2 Nov 2002 16:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSKBV2s>; Sat, 2 Nov 2002 16:28:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40065 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261427AbSKBV2r>;
	Sat, 2 Nov 2002 16:28:47 -0500
Date: Sat, 2 Nov 2002 22:34:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Luc Saillard <luc.saillard@fr.alcove.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops when using ide-cd with 2.5.45 and cdrecord
Message-ID: <20021102213448.GA3612@suse.de>
References: <20021102210103.GA25617@cedar.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102210103.GA25617@cedar.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, Luc Saillard wrote:
> Hi,
> I'm a using the last cdrecord version (1.11a39) when this oops occurs.
> I can't sync my disks with alt-sys-request because we are in interrupt
> :(

How are you invoking cdrecord? Using ide-scsi?

Please read the bug reporting document.

-- 
Jens Axboe

