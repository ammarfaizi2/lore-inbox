Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271799AbRICUex>; Mon, 3 Sep 2001 16:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271805AbRICUen>; Mon, 3 Sep 2001 16:34:43 -0400
Received: from erasmus.off.net ([64.39.30.25]:5907 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S271799AbRICUe1>;
	Mon, 3 Sep 2001 16:34:27 -0400
Date: Mon, 3 Sep 2001 16:34:48 -0400
From: Zach Brown <zab@zabbo.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: pmhahn@titan.lahn.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuid/msr + devfs
Message-ID: <20010903163448.A22633@erasmus.off.net>
In-Reply-To: <Pine.LNX.4.33.0108121020050.1068-100000@titan.lahn.de> <200109032007.f83K73H27504@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200109032007.f83K73H27504@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Mon, Sep 03, 2001 at 02:07:03PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Better to have a central place which creates per-CPU directories,
> which you can call into and grab a directory for a CPU.

I talked with arjan and rmk about this when playing around with per cpu
statistics stuff.  Is the proc_cpu.c stuff in the patch useful?

	http://www.osdlab.org/sw_resources/cpustat/cpustat-2.4.7.pre5-1.diff

- z
