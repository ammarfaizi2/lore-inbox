Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSCIRLk>; Sat, 9 Mar 2002 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292835AbSCIRLa>; Sat, 9 Mar 2002 12:11:30 -0500
Received: from proj2501.aiss.uic.edu ([131.193.164.90]:21002 "EHLO
	proj2501.aiss.uic.edu") by vger.kernel.org with ESMTP
	id <S288557AbSCIRLQ>; Sat, 9 Mar 2002 12:11:16 -0500
Date: Sat, 9 Mar 2002 11:17:27 -0600 (CST)
From: "Barton, Christopher" <cpbarton@uiuc.edu>
X-X-Sender: cpbarton@proj2501.aiss.uic.edu
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: netconsole patch for 2.5?
In-Reply-To: <Pine.LNX.4.33.0109280939090.1569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0203091051060.27667-100000@proj2501.aiss.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there a netconsole patch for Linux 2.5?  Is netconsole on anyone's
radar for inclusion?

Thanks a lot!

On Fri, 28 Sep 2001, Ingo Molnar wrote:

> 
> On Thu, 27 Sep 2001, Albert Cranford wrote:
> 
> > Great tool Ingo thanks.  Below is a tested tulip patch.
> > Thanks Andrew for the the inspiration.
> 
> thanks Albert - i've added it to the patch, and the latest
> netconsole-2.4.10-C2 version can be downloaded from:
> 
> 	http://redhat.com/~mingo/netconsole-patches/
> 
> NOTE: new client-side utilities are needed as well.
> 
> other changes:
> 
>  - netconsole-server fix from Andreas Dilger
> 
>  - introduced versioning and offsetting of output, to display messages in
>    the correct order even if interim routers reorder packets. Future
>    netconsole-clients should reliably detect the right protocol version.
> 
>  - small cleanups.
> 
> 	Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

