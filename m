Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264602AbSIQUeF>; Tue, 17 Sep 2002 16:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264603AbSIQUeF>; Tue, 17 Sep 2002 16:34:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4622 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264602AbSIQUeD>;
	Tue, 17 Sep 2002 16:34:03 -0400
Date: Tue, 17 Sep 2002 13:35:53 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Duc Vianney <dvianney@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Hyperthreading performance on 2.4.19 and 2.5.32
In-Reply-To: <3D878A90.F5E4B8B0@us.ibm.com>
Message-ID: <Pine.LNX.4.33L2.0209171334180.14033-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002, Duc Vianney wrote:

| The following are data comparing the effects of hyperthreading (HT)on
| stock kernel 2.4.19 and 2.5.32.
| Hardware under test. The hardware is a Xeon 1-CPU MP, 1.6 gigahertz,
| and 2.5 GB RAM.
| Kernel under test. When testing under 2.4.19, the kernel was built
| as an SMP kernel, and was run on the hardware with HT enabled through
| the boot option 'noht'.

HT enabled with 'noht' ??
'noht' means "no HT", "no hyperthreading", disabled.

| When testing under 2.5.32, the kernel was
| built as an SMP kernel, and was run on the hardware with HT enabled
| through selecting ACPI in configuration.

-- 
~Randy

