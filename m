Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVJEPt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVJEPt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbVJEPt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:49:26 -0400
Received: from darwin.snarc.org ([81.56.210.228]:33173 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1030188AbVJEPtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:49:25 -0400
Date: Wed, 5 Oct 2005 17:49:23 +0200
From: Vincent Hanquez <vincent@snarc.org>
To: Pierre Michon <pierreno-spam!org@ensilinx1.imag.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freebox possible GPL violation
Message-ID: <20051005154923.GA14366@snarc.org>
References: <20051005151846.GA760@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005151846.GA760@linux.ensimag.fr>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 05:18:46PM +0200, Pierre Michon wrote:
> Why does it need to reboot when there is a new firmware ?

To use it, exactly like when you reboot your pc to change kernels.

> How they manage to download the firmware (need led driver, ppp, http,
> adsl driver, atm stack, ...)

How do you think some random network card with do netbooting works ?
(got a led driver, ipv4 simplified "stack", dhcp & tftp capabilities)

Just like your pc has a BIOS to search for booting devices

> Please suggest other mailling lists.

the one you CC at first @lists.gpl-violations.org and only this one ...

-- 
Vincent Hanquez
