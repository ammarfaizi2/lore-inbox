Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTADWKB>; Sat, 4 Jan 2003 17:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbTADWKB>; Sat, 4 Jan 2003 17:10:01 -0500
Received: from cibs9.sns.it ([192.167.206.29]:65034 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261594AbTADWJ7>;
	Sat, 4 Jan 2003 17:09:59 -0500
Date: Sat, 4 Jan 2003 23:18:29 +0100 (CET)
From: venom@sns.it
To: Joshua Stewart <joshua.stewart@comcast.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tryint to enable support for lm_sensors
In-Reply-To: <1041719036.2877.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.43.0301042317250.21582-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you are missin lm_sensors-2.6.5 packages.
The modules you are talking about do not come with kernel sources, but are
included in another package.

bests
Luigi

On Sat, 4 Jan 2003, Joshua Stewart wrote:

> Date: Sat, 04 Jan 2003 17:23:55 -0500
> From: Joshua Stewart <joshua.stewart@comcast.net>
> To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Tryint to enable support for lm_sensors
>
> What options (int make xconfig) do I have to enable to get the i2c-via
> and i2c-viapro modules to build .  I realized that the kernels and
> modules that Redhat provided included these two modules, but when I
> built a 2.4.20 kernel (downloaded from kernel.org) those modules were
> not built.  I chose support for i2c as a module and the i2c-proc and
> i2c-core modules were built just fine.  What am I missing?
>
> Josh
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

