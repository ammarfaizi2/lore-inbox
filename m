Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbULFOjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbULFOjF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbULFOjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:39:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:54218 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261219AbULFOi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:38:56 -0500
Subject: Re: cpufreq: shouldn't scaling_min_freq be lower?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Bettler <bettlert@student.ethz.ch>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412060029.49366.bettlert@student.ethz.ch>
References: <200412052306.07460.bettlert@student.ethz.ch>
	 <E1Cb5lT-0007vk-00@chiark.greenend.org.uk>
	 <200412060029.49366.bettlert@student.ethz.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102340086.13485.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Dec 2004 13:34:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-05 at 23:29, Thomas Bettler wrote:
> > Windows tends to use a combination of CPU scaling and throttling to get
> > the processor that slow. Take a look at
> > /proc/acpi/processor/*/throttling
> 
> Is there a throttle daemon for Linux? It would be great to use this.

There are a few. cpuspeed for example

