Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271159AbTHHB5q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 21:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbTHHB5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 21:57:46 -0400
Received: from [66.212.224.118] ([66.212.224.118]:14610 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271159AbTHHB5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 21:57:45 -0400
Date: Thu, 7 Aug 2003 21:45:47 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ro0tSiEgE LKML <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no exec after kernel bootup on Elan
In-Reply-To: <00bc01c35d25$748c22e0$0500000a@bp>
Message-ID: <Pine.LNX.4.53.0308072145040.12875@montezuma.mastecende.com>
References: <00bc01c35d25$748c22e0$0500000a@bp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Ro0tSiEgE LKML wrote:

> I have kernel 2.4.21 on a Soekris net4521 (Elan SC520), and after the kernel
> finishes booting up, (when it's supposed to exec init or whatever program I
> specify), nothing happens, I get no output past the line "Freeing unused
> kernel memory: 120k free".
> 
> I get the same results with any program I specify, whether static and
> dynamically compiled.

Did you try what i asked in my reply to your previous email?

-- 
function.linuxpower.ca
