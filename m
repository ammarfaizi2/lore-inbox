Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWINQIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWINQIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWINQIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:08:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58560 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750952AbWINQIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:08:24 -0400
Date: Thu, 14 Sep 2006 12:08:14 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060914160814.GA27313@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org
References: <20060913065010.GA2110@ff.dom.local> <20060913164251.GD13956@redhat.com> <200609141212.50636.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609141212.50636.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 12:12:50PM +0200, Andi Kleen wrote:
 > On Wednesday 13 September 2006 18:42, Dave Jones wrote:
 > > On Wed, Sep 13, 2006 at 08:50:10AM +0200, Jarek Poplawski wrote:
 > >  > Probably after 2.6.18-rc6-git1 there is this cc warning:
 > >  > "arch/i386/kernel/mpparse.c:231: warning: comparison is
 > >  > always false due to limited range of data type".
 > >  > Maybe this patch will be helpful.
 > >  >
 > 
 > It's already fixed.
 > 
 > -Andi

Still looks busted to me in 2.6.18rc7

	Dave 
