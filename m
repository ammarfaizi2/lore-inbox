Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSKYRaf>; Mon, 25 Nov 2002 12:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSKYRaf>; Mon, 25 Nov 2002 12:30:35 -0500
Received: from air-2.osdl.org ([65.172.181.6]:22144 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S262289AbSKYRae>; Mon, 25 Nov 2002 12:30:34 -0500
Subject: Re: [Benchmark] AIM results
From: "Timothy D. Witham" <wookie@osdl.org>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021125114124.13129.qmail@linuxmail.org>
References: <20021125114124.13129.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1038245754.1423.36.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Nov 2002 09:35:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I think that as a point of comparison it has value. That is
one of the reasons that these are automatically run on STP. 

 
http://www.osdl.org/cgi-bin/stp.cgi?modulename=stp&command=search&sort=%21Completion_date&d_Status=completed&d_Distro_tag_uid=&d_Patch_tag=&d_Test_uid=aim9&d_Host_uid=&d_Project_uid=&op=Search

 (Sorry for the long URL)


  However it would be nice to see the code updated for a
different environment that the assumed VAX 11/780. As
that was the original baseline for the test.  Block sizes,
and maybe things like making fakeh.tar to something like
the 2.4.19 kernel.  This has been discussed a couple of
times I think that it will just take some body to lead
it. If you need equipment to test this on larger machines
we have some available.

Tim

On Mon, 2002-11-25 at 03:41, Paolo Ciarrocchi wrote:
> From: Andrew Morton <akpm@digeo.com>
> > Paolo Ciarrocchi wrote:
> > > 
> > > Hi all,
> > > I've ran the AIM benchmark against 2.4.19 and 2.5.49 on my laptop (PIII@800 Reiserfs)
> > 
> > AIM9, I assume.
> 

> Yes
>  
> > It's a rather dumb benchmark, but fun.  Lots of really tiny
> > microbenchmarks, easy to see what's going on.
> 
> I can run it for every 2.5.* linus will release. 
> Do you think it is a good idea or just a waste of time ?
> 
> Paolo
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

