Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVACV5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVACV5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVACV5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:57:44 -0500
Received: from jubilee.implode.net ([64.40.108.188]:65409 "EHLO
	jubilee.implode.net") by vger.kernel.org with ESMTP id S261885AbVACVw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:52:56 -0500
Date: Mon, 3 Jan 2005 13:52:50 -0800
From: John Wong <kernel@implode.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise IDE DMA issue
Message-ID: <20050103215250.GA9409@gambit.implode.net>
References: <20050102173704.GA14056@gambit.implode.net> <41D9885B.9090304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D9885B.9090304@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest 1.009 BIOS flashed last night.  I'll try out some BIOS settings, 
but the settings work fine with Windows XP.  That's why I think it could 
be something with the driver.  This is with the PDC202XX_NEW on kernel 
2.6.10  The DMA timeout happens sporadically, but as of yet, has yet to
reoccur.  The change from 1.008 to 1.009 mentions nothing about the
Promide IDE.  

John

On Mon, Jan 03, 2005 at 01:00:59PM -0500, Jeff Garzik wrote:
> John Wong wrote:
> >I recently upgraded fron a nVidia nForce2 MCP-T based A7NX-DX
> >motherboard to an A8V DX, Via K8T800 Pro.  Now occassionally, I get 
> >DMA issues on a drive attached to a Promise 133 TX2 controller (20269).
> 
> I would try fiddling with BIOS settings, and make sure you have the 
> latest BIOS.
> 
> 	Jeff
> 
> 
> 
> 
