Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUEBGiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUEBGiW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUEBGiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:38:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:2964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261231AbUEBGiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:38:21 -0400
Date: Sat, 1 May 2004 23:32:55 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       mhw@wittsend.com
Subject: Re: [PATCH 2.6.5] Add class support to drivers/char/ip2main.c
Message-ID: <20040502063255.GB3766@kroah.com>
References: <116700000.1081902014@w-hlinder.beaverton.ibm.com> <20040413173406.6d62c782.rddunlap@osdl.org> <126220000.1081963681@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <126220000.1081963681@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 10:28:02AM -0700, Hanna Linder wrote:
> --On Tuesday, April 13, 2004 05:34:06 PM -0700 "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
> > * use consistent spacing (lines) before labels.  None needed here (before out_chrdev:).
> 
> Thanks for the comments Randy, I have made all the changes you suggested. I have 
> also recompiled and tested this patch. Here it is.

Applied, thanks.

greg k-h
