Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWA0Bed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWA0Bed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWA0Bed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:34:33 -0500
Received: from fmr22.intel.com ([143.183.121.14]:41406 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964880AbWA0Bed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:34:33 -0500
Date: Thu, 26 Jan 2006 17:34:24 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Williams <pwil3058@bigpond.net.au>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: smp 'nice' bias support breaks scheduler behavior
Message-ID: <20060126173423.B19789@unix-os.sc.intel.com>
References: <20060126025220.B8521@unix-os.sc.intel.com> <43D95D04.8050802@bigpond.net.au> <20060126155623.A19789@unix-os.sc.intel.com> <200601271229.02752.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200601271229.02752.kernel@kolivas.org>; from kernel@kolivas.org on Fri, Jan 27, 2006 at 12:29:02PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 12:29:02PM +1100, Con Kolivas wrote:
> We planned to push it for 2.6.16 but issues showed up, which Peter has since 
> addressed - but this means the code has not had enough testing to go into 
> 2.6.16 - so it is likely to be in 2.6.17.

Then for 2.6.16, I would like to see smp nice handling patch backed out.

Do you agree?

thanks,
suresh
