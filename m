Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUKHVlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUKHVlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUKHVlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:41:46 -0500
Received: from mout2.freenet.de ([194.97.50.155]:2979 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261244AbUKHVl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:41:27 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH 2.6] fix address passing of unknown_bootoption
Date: Mon, 8 Nov 2004 22:40:21 +0100
User-Agent: KMail/1.7.1
References: <200411072247.39841.mbuesch@freenet.de> <200411080943.43734.mbuesch@freenet.de> <418FAFF6.70400@osdl.org>
In-Reply-To: <418FAFF6.70400@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411082240.21888.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Randy.Dunlap" <rddunlap@osdl.org>:
> Michael Buesch wrote:
> > Quoting "Randy.Dunlap" <rddunlap@osdl.org>:
> > 
> >>>hm, I don't know what happened there.  Maybe the value of pm_idle in
> >>>cpu_idle() is garbage.  Or maybe not.
> >>
> >>Zwane and someone else had patches for that happening IIRC
> >>a month or 2 back.
> >>I can dig them out if wanted... Michael, want to try?
> > 
> > 
> > 
> > Yes, sure. Please.
> 
> OK, there are several patches flying around that may fix this.
> or maybe not...
> 
> And I don't know what it already in -ckX -acN either, so they might
> not apply cleanly.  (also checking -mm now....)
> 
>  From BlaisorBlade:
> http://marc.theaimsgroup.com/?l=acpi4linux&m=109441393614805&w=2
> 
>  From Shaohua Li:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109470272821630&w=2
> 
>  From Zwane (update of above):
> http://marc.theaimsgroup.com/?l=acpi4linux&m=109473286622679&w=2

Already applied. (Don't know. Maybe ck or ac did it).
Must be something else going on here. :(

Thanks for digging them out, anyway.
