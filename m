Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbSJWFT5>; Wed, 23 Oct 2002 01:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSJWFT5>; Wed, 23 Oct 2002 01:19:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:53420 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262868AbSJWFT4>; Wed, 23 Oct 2002 01:19:56 -0400
Date: Tue, 22 Oct 2002 22:24:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: landley@trommello.org, linux-kernel@vger.kernel.org
cc: Guillaume Boissiere <boissiere@adiglobal.com>
Subject: Re: Crunch Time, in 3D!  (2.5 final merge candidate list, v 1.4)
Message-ID: <2713947410.1035325439@[10.10.2.3]>
In-Reply-To: <200210221719.41868.landley@trommello.org>
References: <200210221719.41868.landley@trommello.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Similarly, the "VM Large Page Support", which is a pretty vague
> entry in the 2.5 status list (attributed to "many people" and
> pointing to http://lse.sf.net which is an umbrealla organization
> for many smaller projects), has managed to avoid all efforts
> to track down a related patch.  Rohit Seth at intel seems to think
> it might be this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102824901019428&w=2
> 
> Which already went in.  So until somebody steps up claim that
> "VM Large Page Support" is not the same as hugetlb patch Linus
> already merged, 

It's not ;-)

> that's out.

Try looking in -mm tree for anything that says hugetlb on it.
(or searching lkml for hugetlb subject lines). Yeah, I know
that's totally non-intuitive ;-)
This is large page support using more reasonable interfaces,
so it's actually useful.

M.


