Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVKIWfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVKIWfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVKIWfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:35:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:4499 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751056AbVKIWfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:35:03 -0500
Date: Wed, 9 Nov 2005 14:20:29 -0800
From: Greg KH <greg@kroah.com>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
Message-ID: <20051109222029.GA9182@kroah.com>
References: <20051106013752.GA13368@swissdisk.com> <20051106202609.GA12481@elf.ucw.cz> <20051109141216.GB30611@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109141216.GB30611@swissdisk.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 06:12:16AM -0800, Ben Collins wrote:
> We're giving git a go just to see. It's all being done right there, I push
> directly to master.kernel.org (and also mirror it to a local machine where
> ubuntu devs can make better use of it).

I think over time, a set of patches and a clean kernel tree to apply
them to, is easier to handle.  Especially with such excellent tools
availble to do this now (like quilt and patch-utils).

But good luck with this, it will be interesting to see how long you can
handle maintaining the kernel in this manner.

greg k-h
