Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269363AbUIIGjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269363AbUIIGjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 02:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUIIGjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 02:39:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:55989 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269363AbUIIGjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 02:39:10 -0400
Date: Wed, 8 Sep 2004 23:33:19 -0700
From: Greg KH <greg@kroah.com>
To: janitor@sternwelten.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 01/12]  list_for_each: 	arch-alpha-kernel-pci.c
Message-ID: <20040909063319.GA8352@kroah.com>
References: <E1C2bVa-0006ME-VC@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1C2bVa-0006ME-VC@sputnik>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:15:06PM +0200, janitor@sternwelten.at wrote:
> 
> 
> Hi.
> 
> Change for loops with list_for_each().

Thanks, I've applied all of these (with the exception of the one that
Dave Miller already did.)

greg k-h
