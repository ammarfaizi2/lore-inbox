Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUAQMrP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 07:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUAQMrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 07:47:15 -0500
Received: from h196n1fls22o974.bredband.comhem.se ([213.64.79.196]:38576 "EHLO
	latitude.mynet.no-ip.org") by vger.kernel.org with ESMTP
	id S266027AbUAQMrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 07:47:14 -0500
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-tiny1 tree for small systems 
In-Reply-To: Message from ebiederm@xmission.com (Eric W. Biederman) 
   of "16 Jan 2004 06:56:48 MST." <m1vfnc9eu7.fsf@ebiederm.dsl.xmission.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Jan 2004 12:29:27 +0100
From: aeriksson@fastmail.fm
Message-Id: <20040117112931.4D6223F60@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which still leaves:
> 
> > arch/i386/mm/built-in.o(.init.text+0x2e6): In function `mem_init':
> > : undefined reference to `ppro_with_ram_bug'
> > drivers/built-in.o(__ksymtab+0x130): undefined reference to 
> > `pci_pci_problems'
> 

That one pops up if you don't have CPU support for Intel which, at least according to the menus, seems like a valid configuration.

/A 

