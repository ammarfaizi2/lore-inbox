Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTKTSCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTKTSCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:02:21 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:29067 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262176AbTKTSCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:02:20 -0500
Date: Thu, 20 Nov 2003 19:02:19 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
Subject: Re: Measuring per thread CPU consumption & others statistics for NPTL
Message-ID: <20031120180219.GA16629@MAIL.13thfloor.at>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
References: <1068997909.2276.64.camel@abyss.local> <16312.5605.129233.279407@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16312.5605.129233.279407@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 11:27:17AM +1100, Peter Chubb wrote:
> >>>>> "Peter" == Peter Zaitsev <peter@mysql.com> writes:
> 
> 
> Peter> Are there any ways to get similar information for thread rather
> Peter> than process ?
> 
> Peter> Second question is about accuracy - Is any way to get
> Peter> system/user CPU consumption information with more than 1/100
> Peter> sec accuracy ?
> 
> If you apply my microstate accounting patch, you can get nanosecomnd
> resolution per thread.

is there a version for 2.4 available?

TIA,
Herbert

> Peter C
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
