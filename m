Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWFTWCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWFTWCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWFTWCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:02:38 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:45258 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751109AbWFTWCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:02:38 -0400
Date: Wed, 21 Jun 2006 00:02:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Maurice Volaski <mvolaski@aecom.yu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 6451] CONFIG_KMOD is not set for x86_64 but is set to Y
 for i386 and other archs
In-Reply-To: <200606201730.39477.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0606210001060.17281@yvahk01.tjqt.qr>
References: <200606201433.k5KEXbhX003862@fire-2.osdl.org>
 <a06230977c0bdc14545ff@[129.98.90.227]> <200606201730.39477.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hey, is this you? Why on Earth do you want this setting turned off?
>
>Because I don't use it and arch/x86_64/defconfig is my configuration.

If that is your very personal config, I wonder why it is in the kernel. In 
fact, what is defconfig good for if it's not for the general public? Plus, 
the default values can be retrieved by {x,g,q,menu}config from the Kconfig 
files. Slightly puzzled.


Jan Engelhardt
-- 
