Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUIAU1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUIAU1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUIAUZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:25:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8385 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267751AbUIAUSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:18:37 -0400
Subject: Re: Time runs exactly three times too fast
From: john stultz <johnstul@us.ibm.com>
To: Romain Moyne <aero_climb@yahoo.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200409021453.09730.aero_climb@yahoo.fr>
References: <200409021453.09730.aero_climb@yahoo.fr>
Content-Type: text/plain
Message-Id: <1094069950.14662.208.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 01 Sep 2004 13:19:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 05:53, Romain Moyne wrote:
> Hello, I'm french, sorry for my bad english :(
> 
> I have a problem with my kernel: Time runs exactly three times too fast.
> 
> I tested the kernel 2.6.8.1 and the 2.6.9-rc1, no success. 
> It is really strange because yesterday I reinstalled my debian with a kernel 
> 2.6.8.1 (made by me): Time ran correctly. And this morning when I rebooted my 
> computer (Compaq presario R3000 series, R3215EA exactly) the time is running 
> again three times too fast (with the kernel 2.6.8.1 and 2.6.9-rc1).

Hmmm. First of all, if you enable the ACPI PM Time source, does the
problem go away?

thanks
-john

