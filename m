Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbSJUNmH>; Mon, 21 Oct 2002 09:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSJUNmH>; Mon, 21 Oct 2002 09:42:07 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:24083 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261379AbSJUNmF>; Mon, 21 Oct 2002 09:42:05 -0400
Date: Mon, 21 Oct 2002 23:48:03 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: rtnetlink interface state monitoring problems.
In-Reply-To: <Mutt.LNX.4.44.0210212342070.29133-100000@blackbird.intercode.com.au>
Message-ID: <Mutt.LNX.4.44.0210212346480.29169-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, James Morris wrote:

> Andi Kleen implemented a simple and effective workaround this for 2.4
> which has gone into the tree (see netlink_set_nonroot() in rtnetlink.c).  
> 

Forgot to add that it might be possible to get Andi's solution into 2.6.


- James
-- 
James Morris
<jmorris@intercode.com.au>


