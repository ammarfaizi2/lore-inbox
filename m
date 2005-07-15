Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263190AbVGOEFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbVGOEFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 00:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbVGOEFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 00:05:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:43915 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263190AbVGOEFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 00:05:34 -0400
Date: Fri, 15 Jul 2005 06:05:32 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yinghailu@gmail.com>
Cc: "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
Message-ID: <20050715060532.5873f01b@basil.nowhere.org>
In-Reply-To: <2ea3fae105071420529c3e975@mail.gmail.com>
References: <2ea3fae10507141058c476927@mail.gmail.com>
	<Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov>
	<20050714190929.GL23619@wotan.suse.de>
	<2ea3fae1050714194649c66d7e@mail.gmail.com>
	<20050715030518.GS23737@wotan.suse.de>
	<2ea3fae105071420529c3e975@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.0.3 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005 20:52:58 -0700
yhlu <yinghailu@gmail.com> wrote:

> Andi,
> 
> How do yo think about make x86-64 kernel support openfirmware interface?

I don't like it. We already have the old x86 BIOS interfaces and ACPI
and at some point EFI. No need for more.

-Andi
