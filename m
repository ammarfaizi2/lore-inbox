Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUCXRAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUCXRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:00:51 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:48989 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S263772AbUCXRAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:00:50 -0500
From: Jos Hulzink <josh@stack.nl>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: OSS: cleanup or throw away
Date: Wed, 24 Mar 2004 18:02:40 +0100
User-Agent: KMail/1.6.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200403221955.52767.jos@hulzink.net> <20040322215709.GT16746@fs.tum.de>
In-Reply-To: <20040322215709.GT16746@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403241802.40834.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 March 2004 22:57, Adrian Bunk wrote:
>
> OSS will stay in 2.6 (2.6 is a stable kernel series) but it will most
> likely be removed in 2.7.
>
> I wouldn't spend time to fix deprecated warnings in OSS code, such
> cleanups are wasted time for code that will most likely be removed in
> 2.7.

Fair, but as I am not yet ready for the big work, this might be a nice 
exercise to find my way trough the kernel, to commit patches, etc. So I might 
spend a few weekends to it, albeit mostly to get nicer compile statistics :)

Jos
