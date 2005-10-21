Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVJUGma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVJUGma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 02:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVJUGma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 02:42:30 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:42957 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S964877AbVJUGma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 02:42:30 -0400
Date: Fri, 21 Oct 2005 14:42:17 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       joern@wohnheim.fh-wedel.de, mingo@elte.hu
Subject: Re: [PATCH] Adaptive read-ahead v4
Message-ID: <20051021064217.GA3899@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, joern@wohnheim.fh-wedel.de,
	mingo@elte.hu
References: <20051015174731.GA5851@mail.ustc.edu.cn> <20051018025806.GA3963@mail.ustc.edu.cn> <20051017203137.05350739.akpm@osdl.org> <200510201714.48654.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510201714.48654.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 05:14:42PM +0200, Ingo Oeser wrote:
> On Tuesday 18 October 2005 05:31, Andrew Morton wrote:
> [lot of additional page stats]
> > You should treat such informaton as a development aid, really.  People are
> > very unlikely to look at it in real life.
> 
> And put the whole stuff under debugfs, which was made for this AFAIR.
Ok, I'll do it right away.

Thanks,
Wu Fengguang
