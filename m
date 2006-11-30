Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936182AbWK3DVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936182AbWK3DVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 22:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936181AbWK3DVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 22:21:33 -0500
Received: from mga06.intel.com ([134.134.136.21]:50527 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S936179AbWK3DVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 22:21:32 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,477,1157353200"; 
   d="scan'208"; a="168243473:sNHT16868264"
Date: Wed, 29 Nov 2006 18:56:26 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: mm-commits@vger.kernel.org, ak@suse.de, ashok.raj@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] genapic: default to physical mode on hotplug CPU kernels
Message-ID: <20061129185626.D24271@unix-os.sc.intel.com>
References: <200611140109.kAE19f5e014490@shell0.pdx.osdl.net> <20061127141849.A9978@unix-os.sc.intel.com> <20061128063345.GA19523@elte.hu> <20061128111414.A16460@unix-os.sc.intel.com> <20061128202322.GA29334@elte.hu> <20061128143145.B16460@unix-os.sc.intel.com> <20061129071023.GA651@elte.hu> <20061129080834.GA10199@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061129080834.GA10199@elte.hu>; from mingo@elte.hu on Wed, Nov 29, 2006 at 09:08:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 09:08:34AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > hm - indeed. Then we can indeed do the patch below. Nice simplification!
> 
> forgot to convert a few more places - full patch below.

Acked-by: Suresh Siddha <suresh.b.siddha@intel.com>
