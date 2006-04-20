Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWDTA1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWDTA1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 20:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWDTA1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 20:27:01 -0400
Received: from ns.suse.de ([195.135.220.2]:42649 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751333AbWDTA1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 20:27:01 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] x86_64-enable-large-bzImage.patch
Date: Thu, 20 Apr 2006 02:24:34 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060419063056.GA32425@elte.hu>
In-Reply-To: <20060419063056.GA32425@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604200224.34988.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 08:30, Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> enable large bzImages on x86_64. (fix is from x86's build.c) Using this 
> patch i have successfully built and booted an allyesconfig 13MB+ bzImage 
> on x86_64 too:

Merged thanks.
-Andi
