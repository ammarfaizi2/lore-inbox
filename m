Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUHTTXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUHTTXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUHTTXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:23:00 -0400
Received: from mercury.sdinet.de ([193.103.161.30]:36321 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S267341AbUHTTW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:22:56 -0400
Date: Fri, 20 Aug 2004 21:22:51 +0200 (CEST)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] IBM thinkpad Fn+Fx key driver
In-Reply-To: <20040820122809.GA6167@linux.nu>
Message-ID: <Pine.LNX.4.61.0408202119490.20142@mercury.sdinet.de>
References: <20040820122809.GA6167@linux.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Erik Rigtorp wrote:

> I've written a driver for some of the extra keys on the thinkpads. The
> supported keys are: Fn+ F3, F4, F5, F7, F8, F9, F12. It has been tested on
> two diffrent thinkpad x31, but I would like some feedback from testing on
> other thinkpads.

Module compiles, loads, but does nothing for the keys, no acpi events are 
generated.

Kernel 2.6.8-rc3-mm1 with your module on a thinkpad r40e

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
