Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUESPhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUESPhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUESPe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:34:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60833 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264247AbUESPeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:34:00 -0400
Date: Wed, 19 May 2004 09:42:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "O.Sezer" <sezero@superonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] 2.4.27-pre3  backout acpi_fixed_pwr_button
Message-ID: <20040519124209.GA12652@logos.cnet>
References: <40AB36D6.3080808@superonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AB36D6.3080808@superonline.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 01:28:38PM +0300, O.Sezer wrote:
> Marcelo:
> 
> 2.4.27-pre3 still seems to have the acpi_fixed_pwr_button and
> acpi_fixed_sleep_button changes in it, which oopses for me
> upon module unload. Sergey Vlasov's response to my report is
> attached. The original oops report is here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108405180820535&w=2
> 
> If you don't have another fix for it, please apply the included
> patch in order to back that out.

O.Sezer,

I prefer it to come through Len, who is maintaining on ACPI.

Thanks for pushing this.

