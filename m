Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319595AbSIHLVr>; Sun, 8 Sep 2002 07:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319596AbSIHLVr>; Sun, 8 Sep 2002 07:21:47 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:54727 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S319595AbSIHLVq>;
	Sun, 8 Sep 2002 07:21:46 -0400
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Hans-Peter Jansen <hpj@urpla.net>, Alan Cox <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre5-ac4
References: <Pine.NEB.4.44.0209081321200.7218-100000@mimas.fachschaften.tu-muenchen.de>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 08 Sep 2002 13:14:54 +0200
In-Reply-To: <Pine.NEB.4.44.0209081321200.7218-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <m3sn0khgwh.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> writes:

> On 8 Sep 2002, Alexander Hoogerhuis wrote:
> 
> >...
> > CPU:    0
> > EIP:    0010:[<c01f83e8>]    Tainted: PF
> >...
> 
> Which non-free modues (NVidia?) were loaded on your computer? Is the
> problem reproducible without any non-free module loaded _ever_ since the
> last reboot?
> 
> > ttfn,
> > A
> 

Ops, completely forgot that, vmware 3.1.1, I'll get it built without
preempt and no vmware and see if it still blows up :) my bad :)

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
