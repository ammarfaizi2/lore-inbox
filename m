Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUCaXfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUCaXfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:35:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:34183 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262791AbUCaXfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:35:13 -0500
Date: Wed, 31 Mar 2004 14:49:48 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jgarzik@pobox.com, akpm@osdl.org, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add PCI_DMA_{64,32}BIT constants
Message-ID: <20040331224948.GB5490@kroah.com>
References: <20040323052305.GA2287@havoc.gtf.org> <20040329223604.63d981d0.rddunlap@osdl.org> <20040331012615.GA12444@kroah.com> <20040330195804.40b6c7d4.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330195804.40b6c7d4.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 07:58:04PM -0800, Randy.Dunlap wrote:
> 
> Yes, let's move the defines like Jeff suggested.
> Additional (relative) patch is below.

Applied, thanks.

greg k-h
