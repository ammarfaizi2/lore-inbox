Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTLVLIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 06:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTLVLIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 06:08:16 -0500
Received: from nat-ph3-wh.rz.uni-karlsruhe.de ([129.13.73.33]:7308 "EHLO
	au.hadiko.de") by vger.kernel.org with ESMTP id S264377AbTLVLIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 06:08:15 -0500
From: Jens =?iso-8859-1?q?K=FCbler?= <cleanerx@au.hadiko.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: nForce2 keeps crashing during network activity
Date: Mon, 22 Dec 2003 12:08:13 +0100
User-Agent: KMail/1.5.3
References: <200312221451.06331.ross@datscreative.com.au>
In-Reply-To: <200312221451.06331.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312221208.13218.cleanerx@au.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the noapic or acpi=off stabilizes it for you and you want to run with
> apic and io-apic then my patches may help.
>
> You can find them in this thread
>
> Updated Lockup Patches, 2.4.22 - 23 Nforce2, apic timer ack delay, ioapic
> edge for NMI debug
>
> If unsubscribed you can find it here
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4673.html
> or here
> http://lkml.org/lkml/2003/12/21/156

I played a bit around with apic off and on and still it had no effect. My 
board keeps crashing. Seems not to be related to apic.

Jens

