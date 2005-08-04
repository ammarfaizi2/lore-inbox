Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVHDTaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVHDTaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVHDTaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:30:20 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:15696 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262639AbVHDTaR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:30:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ensuheaf3yQ0MZXBb42AAPzkw4C4u7O/Nfm8xt90lqby0qheIr0IZ5KN5eImOaI2FE/9FWV/L9dvgd/HVujpv5Rrt6r3DeUi0JqWCzVWkzoqoEsbvGDvqF53o79LfVvpJb6gGQ765pcM6AyTMz6bs94PyVazZC90y2PHyuOY63Q=
Message-ID: <86802c440508041230143354c2@mail.gmail.com>
Date: Thu, 4 Aug 2005 12:30:17 -0700
From: yhlu <yhlu.kernel@gmail.com>
Reply-To: yhlu <yhlu.kernel@gmail.com>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: mthca and LinuxBIOS
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <521x59a6tb.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	 <20057281331.7vqhiAJ1Yc0um2je@cisco.com>
	 <86802c44050803175873fb0569@mail.gmail.com>
	 <52u0i6b9an.fsf_-_@cisco.com>
	 <86802c44050804093374aca360@mail.gmail.com> <52mznxacbp.fsf@cisco.com>
	 <86802c4405080410236ba59619@mail.gmail.com>
	 <86802c4405080411013b60382c@mail.gmail.com> <521x59a6tb.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ib_mthca: Mellanox InfiniBand HCA driver v0.06 (June 23, 2005)
ib_mthca: Initializing Mellanox Technologies MT25208 InfiniHost III Ex
(Tavor compatibility mode) (0000:04:00.0)
ib_mthca 0000:04:00.0: FW version 000400060002, max commands 64
ib_mthca 0000:04:00.0: FW size 6143 KB (start fcefa00000, end fcefffffff)
ib_mthca 0000:04:00.0: HCA memory size 262143 KB (start fce0000000,
end fcefffffff)
ib_mthca 0000:04:00.0: Max QPs: 16777216, reserved QPs: 1024, entry size: 256
ib_mthca 0000:04:00.0: Max CQs: 16777216, reserved CQs: 128, entry size: 64
ib_mthca 0000:04:00.0: Max EQs: 64, reserved EQs: 1, entry size: 64
ib_mthca 0000:04:00.0: reserved MPTs: 16, reserved MTTs: 16
ib_mthca 0000:04:00.0: Max PDs: 16777216, reserved PDs: 0, reserved UARs: 1
ib_mthca 0000:04:00.0: Max QP/MCG: 16777216, reserved MGMs: 0
ib_mthca 0000:04:00.0: Flags: 00370347
ib_mthca 0000:04:00.0: profile[ 0]--10/20 @ 0x      fce0000000 (size 0x 4000000)
ib_mthca 0000:04:00.0: profile[ 1]-- 0/16 @ 0x      fce4000000 (size 0x 1000000)
ib_mthca 0000:04:00.0: profile[ 2]-- 7/18 @ 0x      fce5000000 (size 0x  800000)
ib_mthca 0000:04:00.0: profile[ 3]-- 9/17 @ 0x      fce5800000 (size 0x  800000)
ib_mthca 0000:04:00.0: profile[ 4]-- 3/16 @ 0x      fce6000000 (size 0x  400000)
ib_mthca 0000:04:00.0: profile[ 5]-- 4/16 @ 0x      fce6400000 (size 0x  200000)
ib_mthca 0000:04:00.0: profile[ 6]--12/15 @ 0x      fce6600000 (size 0x  100000)
ib_mthca 0000:04:00.0: profile[ 7]-- 8/13 @ 0x      fce6700000 (size 0x   80000)
ib_mthca 0000:04:00.0: profile[ 8]--11/11 @ 0x      fce6780000 (size 0x   10000)
ib_mthca 0000:04:00.0: profile[ 9]-- 6/ 5 @ 0x      fce6790000 (size 0x     800)
ib_mthca 0000:04:00.0: HCA memory: allocated 106050 KB/256000 KB
(149950 KB free)
ib_mthca 0000:04:00.0: Allocated EQ 1 with 65536 entries
ib_mthca 0000:04:00.0: Allocated EQ 2 with 128 entries
ib_mthca 0000:04:00.0: Allocated EQ 3 with 128 entries
ib_mthca 0000:04:00.0: Setting mask 00000000000f43fe for eqn 2
ib_mthca 0000:04:00.0: Setting mask 0000000000000400 for eqn 3
ib_mthca 0000:04:00.0: NOP command IRQ test passed
<------------------------------------------------------------------------------------------------------stuck
30s
ib_mthca 0000:04:00.0: Failed to initialize queue pair table, aborting.
ib_mthca 0000:04:00.0: Clearing mask 00000000000f43fe for eqn 2
ib_mthca 0000:04:00.0: Clearing mask 0000000000000400 for eqn 3
ib_mthca: probe of 0000:04:00.0 failed with error -16


On 8/4/05, Roland Dreier <rolandd@cisco.com> wrote:
>     yhlu> i enable CCONFIG_INFINIBAND_MTHCA_DEBUG=y I didn't get any
>     yhlu> more debug info, is that depend other setting?
> 
> It shouldn't depend on anything.  mthca_dbg() gets turned into
> dev_dbg(), which just does dev_printk(KERN_DEBUG,...).  Perhaps you
> have to change your console level to see KERN_DEBUG messages?
> 
> Since you're getting to the call to mthca_init_qp_table(), there are
> mthca_dbg() calls that you should definitely be getting output from.
> 
>  - R.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
