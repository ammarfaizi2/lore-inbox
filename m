Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWHKTli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWHKTli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWHKTli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:41:38 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:28836 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932369AbWHKTlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:41:36 -0400
Date: Fri, 11 Aug 2006 22:41:34 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for review] [69/145] x86_64: Disable DAC on VIA PCI bridges
Message-ID: <20060811194134.GK4745@rhun.haifa.ibm.com>
References: <20060810935.775038000@suse.de> <200608110851.53038.ak@suse.de> <20060811191311.GI4745@rhun.haifa.ibm.com> <200608112136.12378.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608112136.12378.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 09:36:12PM +0200, Andi Kleen wrote:

> At least for this patch it would only make sense if you had a VIA box 
> with memory >4GB (and most likely it wouldn't have booted before) 

I don't think I have a VIA box with >4GB memory, sorry. I'm also
interested however in making sure it doesn't introduce any
regressions on my other boxes...

Cheers,
Muli
