Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWASWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWASWCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWASWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:02:18 -0500
Received: from kanga.kvack.org ([66.96.29.28]:7829 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030281AbWASWCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:02:17 -0500
Date: Thu, 19 Jan 2006 16:57:22 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule SHAPER for removal
Message-ID: <20060119215722.GO16285@kvack.org>
References: <20060119021150.GC19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119021150.GC19398@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 03:11:50AM +0100, Adrian Bunk wrote:
> +What:   Traffic Shaper (CONFIG_SHAPER)
> +When:   July 2006
> +Why:    obsoleted by the code in net/sched/
> +Who:    Adrian Bunk <bunk@stusta.de

This length of obsolete cycles is way too short -- it's not even enough 
time for a single release of a distro to ship with the feature marked as 
obsolete.

		-ben
