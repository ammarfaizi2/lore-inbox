Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVAQJaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVAQJaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAQJaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:30:22 -0500
Received: from mail.suse.de ([195.135.220.2]:2205 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262742AbVAQJ3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:29:53 -0500
Date: Mon, 17 Jan 2005 10:29:48 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [2.6 patch] x86_64: remove duplicate includes
Message-ID: <20050117092948.GC29270@wotan.suse.de>
References: <20041214011030.GT23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214011030.GT23151@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 02:10:30AM +0100, Adrian Bunk wrote:
> There's usually no reason for including the same header file twice.
> 
> The patch below removes such duplicate includes in x86_64 specific 
> files.

Queued. Thanks.

-Andi
