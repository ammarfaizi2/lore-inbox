Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWGaT37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWGaT37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWGaT37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:29:59 -0400
Received: from waste.org ([66.93.16.53]:42433 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030348AbWGaT36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:29:58 -0400
Date: Mon, 31 Jul 2006 14:28:44 -0500
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 built-in command line (resend)
Message-ID: <20060731192844.GK6908@waste.org>
References: <20060731171259.GH6908@waste.org> <44CE54D6.4040309@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CE54D6.4040309@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 12:07:02PM -0700, H. Peter Anvin wrote:
> Matt Mackall wrote:
> >I'm resending this as-is because the earlier thread petered out
> >without any strong arguments against this approach. x86_64 patch to
> >follow.
> 
> "No strong arguments?"
> 
> I still maintain that this patch has the wrong priority in case more 
> than one set of arguments are provided.

But you still haven't answered how that lets you work around firmware
that passes parameters you don't like.

-- 
Mathematics is the supreme nostalgia of our time.
