Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbSLSG5c>; Thu, 19 Dec 2002 01:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbSLSG5c>; Thu, 19 Dec 2002 01:57:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:31435 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267541AbSLSG5b>; Thu, 19 Dec 2002 01:57:31 -0500
Date: Wed, 18 Dec 2002 23:05:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Timothy D. Witham" <wookie@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Message-ID: <747650000.1040281526@titus>
In-Reply-To: <1040276082.1476.30.camel@localhost.localdomain>
References: <200212181908.gBIJ82M03155@devserv.devel.redhat.com>
 <1040276082.1476.30.camel@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Related thought:
>
>   One of the things that we are trying to do is to automate
> patch testing.
>
>   The PLM (www.osdl.org/plm) takes every patch that it gets
> and does a quick "Does it compile test".  Right now there
> are only 4 kernel configuration files that we try but we are
> going to be adding more.  We could expand this to 100's
> if needed as it would just be a matter of adding additional
> hardware to make the compiles go faster in parallel.

URL doesn't seem to work. But would be cool if you had one SMP
config, one UP with IO/APIC, and one without IO/APIC. I seem
to break the middle one whenever I write a patch ;-(

M.

