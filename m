Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbUKTIta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUKTIta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 03:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUKTIta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 03:49:30 -0500
Received: from baikonur.stro.at ([213.239.196.228]:29409 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261223AbUKTIt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 03:49:27 -0500
Date: Sat, 20 Nov 2004 09:49:26 +0100
From: maximilian attems <janitor@sternwelten.at>
To: Jim Nelson <james4765@verizon.net>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] floppy: Reorganize drivers/block/floppy.c
Message-ID: <20041120084926.GC3858@stro.at>
References: <20041105014000.11993.38553.30904@localhost.localdomain> <20041119223142.GJ2202@stro.at> <419EC91D.5030907@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EC91D.5030907@verizon.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Jim Nelson wrote:

> maximilian attems wrote:
> >hmm could you split up your patch in logical hunks?
> 
> Well, it won't apply to 2.6.10-rc2 anyway (sone ACPI stuff was added), so 
> it wouldn't be any less work to re-do it ;)
> 
> I guess I'll just take it in smaller chunks, then - spread out over a few 
> -rc's.
> 

well parts could, with `pushpatch -f`
anyway that's good news. thanks! :-)

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

