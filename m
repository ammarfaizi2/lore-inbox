Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUB1OUW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 09:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUB1OUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 09:20:22 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:63402 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261850AbUB1OUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 09:20:18 -0500
Date: Sat, 28 Feb 2004 08:19:34 -0600 (CST)
From: Olof Johansson <olof@austin.ibm.com>
To: Andi Kleen <ak@suse.de>
cc: torvalds@osdl.org, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>, <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: [PATCH] ppc64: Add iommu=on for enabling DART on small-mem
 machines
In-Reply-To: <p73ad334b90.fsf@verdi.suse.de>
Message-ID: <Pine.A41.4.44.0402280818060.43148-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 2004, Andi Kleen wrote:

> olof@austin.ibm.com writes:
>
> > Below patch makes it possible for people like me with a small-mem G5 to
> > enable the DART. I see two reasons for wanting to do so:
>
> Could you call it iommu=force ?
>
> It would be the same name as on x86-64 for the same thing then and
> a consistent name may be easier to get to driver developers.


Ack! I was wavering between the two options and finally went with =on. :)
Either way is fine with me.


-Olof

Olof Johansson                                        Office: 4E002/905
Linux on Power Development                            IBM Systems Group
Email: olof@austin.ibm.com                          Phone: 512-838-9858
All opinions are my own and not those of IBM




