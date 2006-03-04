Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWCDTRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWCDTRP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 14:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWCDTRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 14:17:15 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:24765 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751900AbWCDTRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 14:17:15 -0500
Date: Sat, 4 Mar 2006 19:17:08 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: gimli <gimli@dark-green.com>
Cc: mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Mactel-linux-devel] Re: [PATCH] /sys/firmware/efi/systab giving incorrect value for smbios
Message-ID: <20060304191707.GA4116@srcf.ucam.org>
References: <20060304180018.GA3695@srcf.ucam.org> <20060304190026.GA4041@srcf.ucam.org> <4409E4A8.70902@dark-green.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4409E4A8.70902@dark-green.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 08:04:08PM +0100, gimli wrote:
> Hi.
> 
> Do you have any idea why the kernel crashes on machines with more then 512 MB ram ?

As yet, absolutely none. I don't have access to a 1GB machine - if it's 
practical to add more, then I'll see what I can do.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
