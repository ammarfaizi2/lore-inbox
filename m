Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290984AbSBGSJ2>; Thu, 7 Feb 2002 13:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291155AbSBGSJS>; Thu, 7 Feb 2002 13:09:18 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20413 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290984AbSBGSJK>; Thu, 7 Feb 2002 13:09:10 -0500
Date: Thu, 7 Feb 2002 11:06:23 -0700
Message-Id: <200202071806.g17I6Ns27196@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, rml@tech9.net,
        nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <E16Ysuo-00014w-00@starship.berlin>
In-Reply-To: <3C629F91.2869CB1F@dlr.de>
	<E16Ysuo-00014w-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On February 7, 2002 04:38 pm, Martin Wirth wrote:
> > The new lock uses a combination of a spinlock and a (mutex-)semaphore.
> 
> Spinaphore :-)

Or mutabloat :-(

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
