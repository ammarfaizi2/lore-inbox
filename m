Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbUA0O6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 09:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUA0O6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 09:58:16 -0500
Received: from ns.suse.de ([195.135.220.2]:60887 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263723AbUA0O6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 09:58:14 -0500
Date: Tue, 27 Jan 2004 15:56:19 +0100
From: Andi Kleen <ak@suse.de>
To: jim.houston@comcast.net
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
Message-Id: <20040127155619.7efec284.ak@suse.de>
In-Reply-To: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004 22:05:29 -0500 (EST)
Jim Houston <jim.houston@comcast.net> wrote:

> 
> Hi Andrew,
> 
> The attached patch updates my kgdb-x86_64-support.patch to work
> with linux-2.6.2-rc1-mm3.

Hi,

I already did this merge yesterday. Didn't you get mail? 


> 
> The conflicts seen with the old patch are the result of Andi Kleen
> pushing a portion of the patch to Linus.  In particular my 
> addition of .cfi directives to the x86_64 assembly files is
> now in Linus's tree.
> 
> This version has also been tested (and now works) with Matt Mackall's
> kgdb over ethernet.

Hmm, It didn't work for me.

-Andi

