Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVF0Vhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVF0Vhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVF0VhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:37:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46536 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261796AbVF0VgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:36:19 -0400
Date: Mon, 27 Jun 2005 12:58:07 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kswapd flaw
Message-ID: <20050627155807.GA10171@logos.cnet>
References: <200506272004.XAA09696@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506272004.XAA09696@raad.intranet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 11:04:08PM +0300, Al Boldi wrote:
> 
> In 2.4.31 kswapd starts paging during OOMs even w/o swap enabled.
> 
> Is there a way to fix/disable this behaviour?

Al,

What do you mean by paging? Can you be more detailed on the problem 
description please?
