Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVF1IjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVF1IjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVF1IO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:14:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:55492 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261884AbVF1IJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:09:59 -0400
Date: Tue, 28 Jun 2005 00:40:46 -0700
From: Greg KH <greg@kroah.com>
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628074046.GB3577@kroah.com>
References: <20050624081808.GA26174@kroah.com> <42BC3E9D.6030306@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BC3E9D.6030306@billgatliff.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 12:10:53PM -0500, Bill Gatliff wrote:
> 
> I moved your Kconfig diff; it was showing up in miscellaneous 
> filesystems, I put it in pseudo filesystems instead.

Ah, thanks, that's a better place for it.

greg k-h
