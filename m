Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVEAOua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVEAOua (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVEAOua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 10:50:30 -0400
Received: from b.relay.invitel.net ([62.77.203.4]:60885 "EHLO
	b.relay.invitel.net") by vger.kernel.org with ESMTP id S261649AbVEAOuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 10:50:18 -0400
Date: Sun, 1 May 2005 16:50:10 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: =?iso-8859-2?Q?Beno=EEt?= Rouits <brouits@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compaq Armada E500 notebook and 2.6.x kernels
Message-ID: <20050501145010.GA24324@vega.lgb.hu>
Reply-To: lgb@lgb.hu
References: <1114956905.12478.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1114956905.12478.8.camel@localhost.localdomain>
X-Operating-System: vega Linux 2.6.10-5-686 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 04:15:04PM +0200, Benoît Rouits wrote:
> I recently installed a 2.6.10 and 2.6.11 kernel on my laptop and they
> froze about 5 minutes after booting. My solution was to give those 2
> options to the kernels:
> lilo boot: mykernel noapic nolapic
> apic and Local apic are Advanced Programmable Interrupt Controller

Thanks. I know what apic and acpi means :) The problem that I tried these
as well. Some combination seems work well, but eg a day later, booting with
them cause freeze again. Nothing works after this point, I need to pull
out and then puch back the battery to do ANYTHING with the frozen notebook.

- Gábor
