Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTDIQNY (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTDIQNX (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:13:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27608 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263333AbTDIQNV (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 12:13:21 -0400
Date: Wed, 9 Apr 2003 09:27:22 -0700
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 563] New: Build failure at drivers/media/video/zr36120.c
Message-ID: <20030409162722.GC1518@kroah.com>
References: <190330000.1049902398@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <190330000.1049902398@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 08:33:18AM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=563
> 
>            Summary: Build failure at drivers/media/video/zr36120.c
>     Kernel Version: 2.5.67
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: tobias@fresco.org
> 
> 
> Distribution: source from ftp.kernel.org
> Hardware Environment: mobile PIII
> Software Environment: Debian
> Problem Description: Build fails at drivers/media/video/zr36120.c
> 
> Steps to reproduce: Configuret the kernel to  include the "Zoran ZR36120/36125
> Video For Linux" driver (in this case as a module)

Known problem, new zoran drivers are in the pipeline to be submitted to
the main kernel tree.

greg k-h
