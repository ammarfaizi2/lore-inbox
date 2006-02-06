Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWBFUTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWBFUTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWBFUTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:19:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45578 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932375AbWBFUTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:19:39 -0500
Date: Mon, 6 Feb 2006 20:19:29 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Avi Kivity <avi@argo.co.il>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
Message-ID: <20060206201929.GB2470@ucw.cz>
References: <20060202192414.GA22074@redhat.com> <43E2A784.2070809@argo.co.il> <20060203014645.GD10209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203014645.GD10209@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > here? it seems more readable and more correct as well.
> 
> More readable ? Are you kidding ?

Well, his method really counts flipped bits. It looks very obvious
to me -- unlike magic numbers.

-- 
Thanks, Sharp!
