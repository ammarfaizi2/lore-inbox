Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUEBG4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUEBG4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUEBG4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:56:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:29594 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261993AbUEBG4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:56:19 -0400
Date: Sat, 1 May 2004 23:46:18 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, roms@lpg.ticalc.org,
       linux-parport@lists.infradead.org
Subject: Re: [PATCH 2.6.6-rc3] add class support to drivers/char/tipar.c
Message-ID: <20040502064618.GE3766@kroah.com>
References: <53520000.1083190166@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53520000.1083190166@dyn318071bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 03:09:26PM -0700, Hanna Linder wrote:
> 
> This patch adds class support to the Texas Instruments graphing calculators
> with a parallel link cable.
> 
> I have verified it compiles. If someone has the hardware please verify it works.

Applied, thanks.

greg k-h
