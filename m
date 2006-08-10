Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWHJWsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWHJWsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 18:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWHJWsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 18:48:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:55345 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWHJWsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 18:48:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BcnfR5e/xixIABdIbqGjcSASPyhwfTKLSH17xOAtPCA5NdudqF1E/gC5MpHQ65dtwzVEzxgzGuJsbAYE5wF5QuPqvbnQpzOsfHFY+qgsQ8ThP34OR0UZwxrnJNdsK0v0rKfkRm/tLKpn4mesi8t/JXbZ0poVvFhRdi20nV0W9qs=
Date: Fri, 11 Aug 2006 02:48:12 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic:BUG in cascade at kernel/timer.c
Message-ID: <20060810224812.GD6845@martell.zuzino.mipt.ru>
References: <F795765B112E7344AF36AA9112796415019ED349@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F795765B112E7344AF36AA9112796415019ED349@xmb-sjc-212.amer.cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 02:26:15PM -0700, Bizhan Gholikhamseh (bgholikh) wrote:
> We have developed our own custom board based on MPC8541 board running
> linux 2.6.11 During stress testing the system we get following kernel
> panic which related to timer cascase.
> Any hints greatly apprieciated.

Put source somewhere so people can find bug in it.

> kernel BUG in cascade at kernel/timer.c:416!
> Tainted: P

