Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVK3DQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVK3DQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 22:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVK3DQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 22:16:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750823AbVK3DQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 22:16:39 -0500
Date: Tue, 29 Nov 2005 19:16:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: Linux 2.6.15-rc3
In-Reply-To: <20051129184606.10900cf5@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511291915470.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <200511292247.09243.rjw@sisk.pl>
 <200511292342.36228.rjw@sisk.pl> <20051129145328.3e5964a4@dxpl.pdx.osdl.net>
 <20051129233744.GA32316@kroah.com> <20051129161731.69ce252c@dxpl.pdx.osdl.net>
 <20051129162519.1ef07387.akpm@osdl.org> <20051129164222.66d00ca1@dxpl.pdx.osdl.net>
 <Pine.LNX.4.64.0511291754350.3135@g5.osdl.org> <20051129184606.10900cf5@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Nov 2005, Stephen Hemminger wrote:
> 
> Okay, with updated -git tree + usb fix, that system boots and runs
> again. Looks like time for -rc3.1

I'll do an -rc4, but I'll wait for Greg to forward the patch properly. 
There migth be other issues pending.

			Linus
