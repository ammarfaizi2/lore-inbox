Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVAQJdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVAQJdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVAQJai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:30:38 -0500
Received: from cantor.suse.de ([195.135.220.2]:11678 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262747AbVAQJaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:30:16 -0500
Date: Mon, 17 Jan 2005 10:30:14 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x86_64 traps.c: remove an unused function
Message-ID: <20050117093014.GD29270@wotan.suse.de>
References: <20041207004937.GU7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207004937.GU7250@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 01:49:37AM +0100, Adrian Bunk wrote:
> The patch below removes an unused function.
> 
> It's not compilation tested but grep showed it's unused and I'd already 
> send a similar patch for i386.

Queued. Thanks.

-Andi
