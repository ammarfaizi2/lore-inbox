Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWAFWdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWAFWdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWAFWdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:33:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:21651 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932234AbWAFWds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:33:48 -0500
From: Andi Kleen <ak@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH] x86_64: Sparse warnings fix.
Date: Fri, 6 Jan 2006 23:26:36 +0100
User-Agent: KMail/1.8.2
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20060106120726.6693406e.lcapitulino@mandriva.com.br>
In-Reply-To: <20060106120726.6693406e.lcapitulino@mandriva.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601062326.37005.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 15:07, Luiz Fernando Capitulino wrote:
> 
>  Fixes the following sparse warnings:
> 
> arch/x86_64/kernel/mce_amd.c:321:29: warning: Using plain integer as NULL pointer
> arch/x86_64/kernel/mce_amd.c:410:41: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>


Queued. Thanks.

-Andi
