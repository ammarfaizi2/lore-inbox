Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUCAXzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 18:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUCAXzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 18:55:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:49369 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261468AbUCAXzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 18:55:45 -0500
Date: Mon, 1 Mar 2004 15:55:43 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rename sys_bus_init()
Message-ID: <20040301235543.GB11664@kroah.com>
References: <20040301154210.5958fc02.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040301154210.5958fc02.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 03:42:10PM -0800, Randy.Dunlap wrote:
> Please apply to 2.6.current.
> 
> Thanks,
> --
> ~Randy
> 
> 
> // linux 2.6.4 2004.0301
> desc:	rename sys_bus_init() to system_bus_init() so that
> 	it doesn't appear to be a syscall;

Applied, thanks.

greg k-h
