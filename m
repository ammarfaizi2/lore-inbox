Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbULDOWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbULDOWi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 09:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbULDOWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 09:22:33 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:27151 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262546AbULDOWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 09:22:31 -0500
Date: Sat, 4 Dec 2004 15:22:27 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a.out support - status
Message-ID: <20041204142227.GC8659@pclin040.win.tue.nl>
References: <200412041318.49524.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412041318.49524.nick@linicks.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 01:18:49PM +0000, Nick Warne wrote:

> What is the consensus on having a.out now in the kernel - would only people 
> that run old binaries and/or developers need this function?  Would I need it 
> on a modern box doing just normal usage?
> 
> I googled a bit, but the only information I find is very old.

Only people running old binaries need it.
The kernel harasses them with messages like
 "fd_offset is not page aligned. Please convert program: ..."
