Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVINIrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVINIrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVINIrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:47:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65195 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965086AbVINIrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:47:05 -0400
Date: Wed, 14 Sep 2005 10:46:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jan De Luyck <lkml@kcore.org>
Subject: Re: ACPI S3 and ieee1394 don't get along
Message-ID: <20050914084621.GA1941@elf.ucw.cz>
References: <200509131156.31914.lkml@kcore.org> <20050913102049.GA1876@elf.ucw.cz> <43276CC3.20105@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43276CC3.20105@s5r6.in-berlin.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Last time I checked, you could still break ohci1394 be repeatedly
> >loading it and unloading it.
> 
> Do you have details available on that?
> 
> I never saw such a bug with the two PCI OHCI controllers I can currently 
> test. I'm not running any isochronous applications though.

I asked around and it seems to be gone in recent kernels. So sorry
about the noise.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
