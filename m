Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUEUQ17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUEUQ17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbUEUQ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 12:27:59 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3057 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265879AbUEUQ15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 12:27:57 -0400
Date: Thu, 20 May 2004 11:39:06 -0700
From: cliff white <cliffw@osdl.org>
To: john weber <weber@sixbit.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance Tuning
Message-Id: <20040520113906.0e9f6fec.cliffw@osdl.org>
In-Reply-To: <20040520120514.GA29540@sixbit.org>
References: <20040520120514.GA29540@sixbit.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004 12:05:15 +0000
john weber <weber@sixbit.org> wrote:

> I've been comparing kernel compile stats online to those I get 
> on my own machine, and I am baffled.
> 
> Kernel compiles take 6m38s on my P4 2.8GHz (with HT enabled) and 
> 512 MB RAM as compared to 20-30 seconds reported by folks online. 
> I am running kernel 2.6.6.
> 
> While I understand that this varies with the config, I also don't 
> see why it should vary so much.  Does anyone have any pointers on 
> how I could best troubleshoot my performance?

That sounds about right for your hardware. As Valdis mentioned, 20 second
compiles just don't happen on UP machines, at least not at that clock speed.
cliffw

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
