Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUBDCS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 21:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUBDCS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 21:18:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7147 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266293AbUBDCST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 21:18:19 -0500
Date: Tue, 3 Feb 2004 21:18:11 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Clay Haapala <chaapala@cisco.com>, Matt Mackall <mpm@selenic.com>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib
 routines
In-Reply-To: <20040203172508.B26222@lists.us.dell.com>
Message-ID: <Xine.LNX.4.44.0402032115090.2718-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Matt Domsch wrote:

> > >> +MODULE_LICENSE("GPL and additional rights");
> > > 
> > > "additional rights?"
> > > 
> > Take it up with Matt_Domsch@dell.com -- it's his code that I
> > cribbed, so that's the license line I used.
> 
> The crc32 code came from linux@horizon.com with the following
> copyright abandonment disclaimer, which is still in lib/crc32.c:
> 
> /*
>  * This code is in the public domain; copyright abandoned.
>  * Liability for non-performance of this code is limited to the amount
>  * you paid for it.  Since it is distributed for free, your refund will
>  * be very very small.  If it breaks, you get to keep both pieces.
>  */
> 
> Thus GPL plus additional rights is appropriate.
> 

Placing the code in the public domain then adding additional rights seems 
to be inherently conflicted.

People will pay for distribution of the code, so these additional rights 
would not be acceptable anyway.

(IMHO).


- James
-- 
James Morris
<jmorris@redhat.com>


