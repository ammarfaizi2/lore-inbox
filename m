Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTJKB6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 21:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbTJKB6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 21:58:17 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:53379
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263229AbTJKB6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 21:58:15 -0400
Date: Fri, 10 Oct 2003 21:58:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ACPI year blacklist
In-Reply-To: <20031010233616.GA2214@werewolf.able.es>
Message-ID: <Pine.LNX.4.53.0310102156590.15705@montezuma.fsmlabs.com>
References: <20031010233616.GA2214@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Oct 2003, J.A. Magallon wrote:

> I have and (oldie...) SuperMicro P6DGU mobo with ACPI, but the kernel says
> it is too old (before 99, I think...).
> 
> Why are this BIOSes blacklisted ?

Because it's a hit and miss affair with the older bioses, so we just play 
it safe and don't run on them. Microsoft Windows does the same thing iirc.

