Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUIGPmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUIGPmH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268304AbUIGPlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:41:46 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:49657 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268316AbUIGPk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:40:58 -0400
Date: Tue, 7 Sep 2004 11:45:26 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.9-rc1-mm4
In-Reply-To: <20040907020831.62390588.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0409071142500.14053@montezuma.fsmlabs.com>
References: <20040907020831.62390588.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morning Andrew,

On Tue, 7 Sep 2004, Andrew Morton wrote:

> +correct-elf-section-used-for-out-of-line-spinlocks.patch
> 
>  Fix the out-of-line spinlock code

Could you drop this patch, there is a conflicting fix in linus.patch which 
was discussed with Anton.

Thank you,
	Zwane

