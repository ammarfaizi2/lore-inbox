Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUK2LjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUK2LjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUK2LjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:39:12 -0500
Received: from pD9562C58.dip.t-dialin.net ([217.86.44.88]:36209 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261678AbUK2LjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:39:04 -0500
Date: Mon, 29 Nov 2004 12:36:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: davem@redhat.com, jgarzik@pobox.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove dp83840.h
Message-ID: <20041129113613.GA2718@linux-mips.org>
References: <20041129111943.GB9722@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129111943.GB9722@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 12:19:43PM +0100, Adrian Bunk wrote:

> dp83840.h is included once but none of the definitions it contains is 
> actually used.
> 
> Is the patch below to remove it OK, or is there any usage planned?

I would suggest to keep the file as documentation of the DP83840.

  Ralf
