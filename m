Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUIMMYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUIMMYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUIMMYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:24:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:36492 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266572AbUIMMYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:24:11 -0400
Date: Mon, 13 Sep 2004 14:24:10 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Allow multiple inputs in alternative_input
Message-ID: <20040913122410.GA13542@wotan.suse.de>
References: <Pine.LNX.4.53.0409130823170.2297@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409130823170.2297@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 08:26:55AM -0400, Zwane Mwaikambo wrote:
> Hi Andi,
> 	I had to use the following patch to allow multiple arguments to be 
> passed down to the asm stub for alternative_input whilst writing 
> alternatives for mwait code, it seems like a simple enough fix.

Looks good. 

-Andi

