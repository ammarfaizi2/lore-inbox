Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270640AbTHPPNN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270676AbTHPPNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:13:13 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:61832 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270640AbTHPPNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:13:10 -0400
Subject: Re: Centrino support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Rychter <jan@rychter.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m2oeyq3bi2.fsf@tnuctip.rychter.com>
References: <m2wude3i2y.fsf@tnuctip.rychter.com>
	 <1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
	 <m2oeyq3bi2.fsf@tnuctip.rychter.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061046769.10596.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 16 Aug 2003 16:12:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-15 at 21:35, Jan Rychter wrote:
> Question time:
> 
> 1. Will cpufreq make it into the standard 2.4 kernels?

In time maybe - up to Marcelo. 

> 2. If not, will Alan incorporate swsusp into -ac kernels? (given that
>    -ac kernels seem to have cpufreq included)

Not in its current form. To do the job well swsuspend needs the kernel 
device model. 


