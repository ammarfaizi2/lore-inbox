Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbUKQAUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbUKQAUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUKQASt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:18:49 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:59143 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261873AbUKQARO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:17:14 -0500
Date: Wed, 17 Nov 2004 01:16:50 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, akpm <akpm@osdl.org>, ak@suse.de,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: [PATCH] PCI: fix build errors with CONFIG_PCI=n
Message-ID: <20041117001650.GC2868@pclin040.win.tue.nl>
References: <419A8088.3010205@osdl.org> <20041116232600.GB2868@pclin040.win.tue.nl> <419A8EFE.8060508@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419A8EFE.8060508@osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 03:36:30PM -0800, Randy.Dunlap wrote:

> >  static int __init parport_init_mode_setup(char *str) {
> 
> Yes, I'm familiar with that, but I made a patch against current
> top of tree.

I don't understand. Will you send another patch to fix the prototype?

Andries
