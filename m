Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317364AbSGZM4Q>; Fri, 26 Jul 2002 08:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317683AbSGZM4Q>; Fri, 26 Jul 2002 08:56:16 -0400
Received: from smtp.intrex.net ([209.42.192.250]:9743 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S317364AbSGZM4Q>;
	Fri, 26 Jul 2002 08:56:16 -0400
Date: Fri, 26 Jul 2002 09:06:15 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] Thread-Local Storage (TLS) support for Linux, 2.5.28
Message-ID: <20020726090615.B958@tricia.dyndns.org>
References: <Pine.LNX.4.44.0207251857220.3732-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207251857220.3732-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Jul 25, 2002 at 07:35:34PM +0200
X-Declude-Sender: jlnance@intrex.net [216.181.42.97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 07:35:34PM +0200, Ingo Molnar wrote:
> 
> the following patch implements proper x86 TLS support in the Linux kernel,
> via a new system-call, sys_set_thread_area():

Ingo,
    Its great that you can add a feature and make the code smaller and
faster at the same time.  Good job!

Jim
