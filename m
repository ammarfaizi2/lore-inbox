Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUBKNfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 08:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUBKNfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 08:35:31 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:34973 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S263787AbUBKNf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 08:35:26 -0500
Subject: Re: does Linux Kernel 2.2 supports Xeon 2 SMP?
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: liyongc@lenovo.com
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <OF42E0E7BA.344B54AE-ON48256E37.002B3232@legend.com.cn>
References: <OF42E0E7BA.344B54AE-ON48256E37.002B3232@legend.com.cn>
Content-Type: text/plain
Message-Id: <1076505104.3783.1.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 15:11:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-11 at 10:05, liyongc@lenovo.com wrote:
> Hi, I have a Xeon 2 SMP machine, and install a TurboLinux 6.0 with kernel
> 2.2.18-2xx.
> When I boot unique processor kernel, everything is OK. when I boot
> symmetric multiple processor kernel, there are only two lines displayed on
> console:
> 
> and then kernel hang up.
> 
> I wonder if kernel 2.2 does not support Xeon 2 SMP. If Kernel 2.2 really
> doesn't support Xeon2 SMP, I'll have to give up ....
> 
> Thanks for you all.
Well, it may support it, but not as greatly as 2.4 or 2.6, so why don't
you update your kernel to 2.4/2.6? Or is there a specific reason why you
want to keep 2.2.18? SMP support in newer kernels are alot better than
in the 2.2 series.

        Markus

