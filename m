Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbTCYGpv>; Tue, 25 Mar 2003 01:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTCYGpv>; Tue, 25 Mar 2003 01:45:51 -0500
Received: from CPE-203-51-35-166.nsw.bigpond.net.au ([203.51.35.166]:7296 "EHLO
	didi") by vger.kernel.org with ESMTP id <S261539AbTCYGps>;
	Tue, 25 Mar 2003 01:45:48 -0500
Date: Tue, 25 Mar 2003 17:56:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
To: linux-kernel@vger.kernel.org, akpm@digeo.com, axboe@suse.de
Subject: Re: [BENCHMARK] AS vs. DL schedulers
Message-ID: <20030325065656.GA911@didi>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@digeo.com,
	axboe@suse.de
References: <20030325063544.GB332@didi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325063544.GB332@didi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Mar 25, 2003 at 05:35:44PM +1100, Nick Piggin wrote:
>
> Here are some benchmarks.
>
Machine is UP PIV 2.0 (512K), 256MB no swap
ICH4: IDE controller at PCI slot 00:1f.1
hda: Maxtor 6E040L0, ATA DISK drive
Target fs for tests was ext2

The kernel used was actually 2.5.65-mm4 with a few minor tweaks to
as-iosched.c

