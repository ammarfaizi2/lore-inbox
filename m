Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTJ1X0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 18:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTJ1X0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 18:26:11 -0500
Received: from ns.suse.de ([195.135.220.2]:45217 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261812AbTJ1X0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 18:26:10 -0500
Date: Wed, 29 Oct 2003 00:25:17 +0100
From: Andi Kleen <ak@suse.de>
To: George Anzinger <george@mvista.com>
Cc: jim.houston@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: Is there a kgdb for Opteron for linux-2.6?
Message-Id: <20031029002517.47d8f329.ak@suse.de>
In-Reply-To: <3F9EF206.1040105@mvista.com>
References: <1066678923.1007.164.camel@new.localdomain>
	<20031024135112.GE2286@wotan.suse.de>
	<3F9EF206.1040105@mvista.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 14:47:34 -0800
George Anzinger <george@mvista.com> wrote:


> 
> I see that Andrew has not picked up my latest kgdb.  In the latest version I 
> have the dwarf2 stuff working in entry.S.  Just ask, off list.

Do you use the .cfi* mnemonics in newer binutils? Without that it would get ugly.

-Andi

