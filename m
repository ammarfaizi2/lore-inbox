Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWJPKPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWJPKPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWJPKPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:15:21 -0400
Received: from mx1.suse.de ([195.135.220.2]:40659 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030345AbWJPKPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:15:20 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] add X86_FEATURE_PEBS and detection
Date: Mon, 16 Oct 2006 12:09:19 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20061006091006.GD8793@frankl.hpl.hp.com>
In-Reply-To: <20061006091006.GD8793@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161209.19503.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 11:10, Stephane Eranian wrote:
> Hello,
> 
> Here is a patch (used by perfmon2) to detect the presence of the
> Precise Event Based Sampling (PEBS) feature for Intel 64-bit processors.
> The patch also adds the cpu_has_pebs macro.
> 
> IMPORTANT: you need to have the X86_FEATURE_DS renaming patch applied first!

Added both thanks. I suppose similar i386 patches will be needed too.

If you have patches that depend on each other please number
them in the future.

-Andi
>
