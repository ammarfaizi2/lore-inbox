Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUIJQDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUIJQDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIJQAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:00:15 -0400
Received: from the-village.bc.nu ([81.2.110.252]:32433 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267507AbUIJP5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:57:04 -0400
Subject: Re: Latest microcode data from Intel.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409101641220.1294-100000@einstein.homenet>
References: <Pine.LNX.4.44.0409101641220.1294-100000@einstein.homenet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094828066.17442.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 15:54:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 16:46, Tigran Aivazian wrote:
> 2. How do you know which device nodes exist on my workstation?

I'm interested how he knows which CPU's are the same too. Only the
microcode driver can really handle the uglies there with HT.

> The microcode_ctl utility had a hardcoded default "/dev/cpu/microcode" and 
> there is no real reason to change it because different distributions 
> prefer a different value, so how to decide who is "right"?

Documentation/devices.txt aka LANANA

