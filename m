Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266396AbUAVSTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUAVSS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:18:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19370 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266363AbUAVSSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:18:53 -0500
Date: Thu, 22 Jan 2004 10:10:28 -0800
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Simplify net/flow.c
Message-Id: <20040122101028.0eab2774.davem@redhat.com>
In-Reply-To: <20040122082303.3B1BC2C18C@lists.samba.org>
References: <20040122082303.3B1BC2C18C@lists.samba.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004 18:49:37 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> 	I still have this cleanup sitting around, and frankly it gets
> in the way for the hotplug CPU code.  It works fine here, and is
> basically trivial, but I'm happy to put it in -mm first for wider
> testing if you want?

No, I made you wait long enough with this patch :) and I just read it
over again a few times and it looks perfectly fine.

So I'm applying this now, thanks Rusty.
