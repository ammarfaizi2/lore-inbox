Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268929AbRHBNxj>; Thu, 2 Aug 2001 09:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268932AbRHBNx3>; Thu, 2 Aug 2001 09:53:29 -0400
Received: from [193.120.224.170] ([193.120.224.170]:25734 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S268929AbRHBNxU>;
	Thu, 2 Aug 2001 09:53:20 -0400
Date: Thu, 2 Aug 2001 14:48:27 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
cc: "Nadav Har'El" <nyh@math.technion.ac.il>, <linux-kernel@vger.kernel.org>,
        <agmon@techunix.technion.ac.il>
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <Pine.LNX.4.33.0108011318120.19875-100000@twin.uoregon.edu>
Message-ID: <Pine.LNX.4.33.0108021446320.32029-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Joel Jaeggli wrote:

> before the althon amd k6's would have used pic design called the open pic
> to do smp... but since nobody implemented the openpic it's kinda hard to
> use it...

grep for openpic in the kernel source. SMP hardware implementing
OpenPIC exists and linux supports it. no-one ever made an /x86/
OpenPIC board.

Also, I'm not sure, but IIRC OpenPIC is pretty much CPU-independent.

> joelja

--paulj

