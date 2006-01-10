Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWAJUbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWAJUbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWAJUbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:31:20 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50608 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932303AbWAJUbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:31:19 -0500
Date: Tue, 10 Jan 2006 15:31:15 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Although CONFIG_IRQBALANCE is enabled IRQ's don't seem to be balanced very well
Message-ID: <20060110203115.GB5479@filer.fsl.cs.sunysb.edu>
References: <9a8748490601100314u26d4a566uc41a1912e410ea46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601100314u26d4a566uc41a1912e410ea46@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 12:14:42PM +0100, Jesper Juhl wrote:
> Do I need any userspace tools in addition to CONFIG_IRQBALANCE?

Last I checked, yes you do need "irqbalance" (at least that's what
the package is called in debian.

Jeff.
