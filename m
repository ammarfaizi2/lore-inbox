Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUDVVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUDVVgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUDVVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:36:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:44947 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264692AbUDVVgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:36:32 -0400
Date: Thu, 22 Apr 2004 14:35:48 -0700
From: Greg KH <greg@kroah.com>
To: Romain Lievin <lkml@lievin.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tipar char driver (divide by zero)
Message-ID: <20040422213548.GE1800@kroah.com>
References: <20040416062635.GA32021@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416062635.GA32021@lievin.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 08:26:35AM +0200, Romain Lievin wrote:
> Hi,
> 
> a set of 2 patches (2.4 & 2.6) about the tipar.c char driver. It fixes
> a divide-by-zero error when we try to read/write data after setting
> timeout to 0.
> 
> Please apply...

Applied to 2.6, thanks.

greg k-h
