Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbUKVVaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUKVVaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbUKVTGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:06:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:60801 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262315AbUKVTEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:04:40 -0500
Date: Mon, 22 Nov 2004 10:54:01 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] visor: Always do generic_startup
Message-ID: <20041122185401.GA6363@kroah.com>
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041121012353.GA4008@himi.org> <20041121040856.GB1569@kroah.com> <20041121071530.GA5586@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121071530.GA5586@himi.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 06:15:30PM +1100, Simon Fowler wrote:
> I've attached the gzipped log file, from the point it the new USB
> device is registered to the point the device nodes are deleted by
> udev.

I don't see anything unusual in the log, sorry.

If you replace the version in your kernel with the visor.c version in
2.6.9, does it work properly for you?

thanks,

greg k-h
