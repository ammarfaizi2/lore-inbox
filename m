Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUCSJnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUCSJnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:43:05 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:54734 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261983AbUCSJnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:43:03 -0500
Date: Fri, 19 Mar 2004 10:42:53 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040319094253.GB17938@wohnheim.fh-wedel.de>
References: <20040315235243.GA21416@wohnheim.fh-wedel.de> <200403161618.i2GGITKK004831@eeyore.valparaiso.cl> <20040316171038.GA27046@wohnheim.fh-wedel.de> <20040319091148.GC2650@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040319091148.GC2650@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 March 2004 09:11:48 +0000, Jamie Lokier wrote:
> [...]
> 
> So my vote is for the very simple COW hard link attribute, and leave
> the rest to userspace.

That makes an overwhelming majority of 100% so far, congratulations!

I'll merge Sytse's fixes and post a new patch soon, followed by a
userspace copyfile() implementation.

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown
