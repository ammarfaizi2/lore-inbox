Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWAaBcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWAaBcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 20:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWAaBcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 20:32:08 -0500
Received: from fmr22.intel.com ([143.183.121.14]:49366 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030257AbWAaBcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 20:32:07 -0500
Date: Mon, 30 Jan 2006 17:31:54 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, ak@suse.de, linux-kernel@vger.kernel.org,
       rohit.seth@intel.com, asit.k.mallick@intel.com
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060130173154.B4851@unix-os.sc.intel.com>
References: <20060126015132.A8521@unix-os.sc.intel.com> <20060129165645.GF1764@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060129165645.GF1764@elf.ucw.cz>; from pavel@suse.cz on Sun, Jan 29, 2006 at 05:56:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 05:56:47PM +0100, Pavel Machek wrote:
> Could we all do it with single CONFIG_SCHED_SMT or CONFIG_NUMA or
> something like that? No need for zillion options...

We thought about it too before and felt that CONFIG_SCHED_MC is more appropriate
and cleaner.

thanks,
suresh
