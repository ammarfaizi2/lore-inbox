Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUAPNH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbUAPNH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:07:28 -0500
Received: from ns.suse.de ([195.135.220.2]:12767 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265433AbUAPNH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:07:27 -0500
Date: Fri, 16 Jan 2004 14:05:51 +0100
From: Andi Kleen <ak@suse.de>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
       pavel@suse.cz, mpm@selenic.com, discuss@x86-64.org, george@mvista.com
Subject: Re: [discuss] KGDB 2.0.3 with fixes and development in ethernet
 interface
Message-Id: <20040116140551.2da2815b.ak@suse.de>
In-Reply-To: <200401161759.59098.amitkale@emsyssoft.com>
References: <200401161759.59098.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004 17:59:59 +0530
"Amit S. Kale" <amitkale@emsyssoft.com> wrote:

> Hi,
> 
> KGDB 2.0.3 is available at 
> http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> 
> Ethernet interface still doesn't work. It responds to gdb for a couple of 
> packets and then panics. gdb log for ethernet interface is pasted below.

Did you add the fix for netpoll Jim posted? 

-Andi


