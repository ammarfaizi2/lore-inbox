Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVKADEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVKADEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKADEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:04:34 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:18889 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S964948AbVKADEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:04:33 -0500
Date: Tue, 1 Nov 2005 11:04:47 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       slpratt@us.ibm.com
Subject: Re: [PATCH 00/13] Adaptive read-ahead V5
Message-ID: <20051101030447.GB3944@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, slpratt@us.ibm.com
References: <20051029060216.159380000@localhost.localdomain> <20051031214514.GA4967@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031214514.GA4967@RAM>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 01:45:14PM -0800, Ram Pai wrote:
> Wu,
> 
> I will run some standard benchmarks and post the results soon.
> The benchmarks I have are (1) DSS (TPCH)  (2) iozone (3) sysbench  (4)
> tiobench
> 
> It will take atleast a week, since some disks on my machine have to be
> replaced and the setup has to be remade.
Thank you for taking the trouble. In the meantime I will prepare a patch
against the stable 2.6.14, so that you can comfortably run vanilla 2.6.14
as the reference point.

Regards,
Wu Fengguang
