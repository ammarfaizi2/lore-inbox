Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbUJaBdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUJaBdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 21:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUJaBdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 21:33:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:63441 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261461AbUJaBdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 21:33:52 -0400
Date: Sun, 31 Oct 2004 02:33:46 +0100
From: Andi Kleen <ak@suse.de>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: jamesclv@us.ibm.com, ak@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] x86-64: fix sibling map again!
Message-ID: <20041031013346.GE19396@wotan.suse.de>
References: <20041029170215.A26372@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029170215.A26372@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 05:02:15PM -0700, Siddha, Suresh B wrote:
> That patch assumes BIOS for non-clustered systems accept the HW assigned
> value. Why make this assumption when we can fix it in a better fashion(which
> is also used by x86 kernel's today)

Thanks Suresh. I applied it to my tree.

-Andi
