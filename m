Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWHPRMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWHPRMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWHPRLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:11:42 -0400
Received: from styx.suse.cz ([82.119.242.94]:29577 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932129AbWHPRLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:11:40 -0400
Date: Wed, 16 Aug 2006 19:11:39 +0200
From: Jiri Benc <jbenc@suse.cz>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060816191139.5d13fda8@griffin.suse.cz>
In-Reply-To: <20060815092551.GA17881@ojjektum.uhulinux.hu>
References: <20050427124911.6212670f@griffin.suse.cz>
	<20060815092551.GA17881@ojjektum.uhulinux.hu>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 11:25:52 +0200, Pozsar Balazs wrote:
> Recently I had similar problems as you described below, that's how I 
> found your email. (My exact problem is that there's no link when I plug 
> in a cable, reloading the driver a few times usually helps.)
> The problem is, that since you made the patch, the uli526x driver has 
> been split out from the tulip driver.
> Do you know anything about the current state of the uli526x driver 
> regarding the problems you tried patch?

I use the card with new (split out) uli526x driver with no problem. Your
problems are probably unrelated.

 Jiri

-- 
Jiri Benc
SUSE Labs
