Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWEOTIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWEOTIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWEOTIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:08:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:9931 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965183AbWEOTIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:08:15 -0400
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F7028FDBFE@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
From: Andi Kleen <ak@suse.de>
Date: 15 May 2006 21:08:11 +0200
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FDBFE@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Message-ID: <p738xp35co4.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA> writes:

> > I also have A8V Deluxe.
> > 
> > No real problems with single core A64 3000.
> > 
> > But now with and X2 dual core CPU, I needed to disable 
> > irqbalance to get any stability.
> 
> Hein? Via xconfig?

I cant't see the parent message (did you mess up the cc?) of the
person with irqbalanced troubles, but most likely he has a SIS chipset, right? 

-Andi
