Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277601AbRJLIwB>; Fri, 12 Oct 2001 04:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277598AbRJLIvw>; Fri, 12 Oct 2001 04:51:52 -0400
Received: from geos.coastside.net ([207.213.212.4]:37300 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S277595AbRJLIvh>; Fri, 12 Oct 2001 04:51:37 -0400
Mime-Version: 1.0
Message-Id: <p05100303b7ec5f78c071@[207.213.214.37]>
In-Reply-To: <946453649.1002878892@[195.224.237.69]>
In-Reply-To: <200110120543.f9C5hvZ224264@saturn.cs.uml.edu>
 <946453649.1002878892@[195.224.237.69]>
Date: Fri, 12 Oct 2001 01:51:17 -0700
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Paul McKenney <Paul.McKenney@us.ibm.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of
 lists  with
Cc: Andrea Arcangeli <andrea@suse.de>, Peter Rival <frival@zk3.dec.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Richard Henderson <rth@twiddle.net>, cardoza@zk3.dec.com,
        woodward@zk3.dec.com,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:28 AM +0100 10/12/01, Alex Bligh - linux-kernel wrote:
>>There is a memory barrier instruction called "eieio"
>
>This must be April 1 by some calendar.

PPC "Enforce In-Order Execution of I/O"
-- 
/Jonathan Lundell.
