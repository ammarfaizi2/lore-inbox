Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313450AbSDQS7h>; Wed, 17 Apr 2002 14:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313422AbSDQS7g>; Wed, 17 Apr 2002 14:59:36 -0400
Received: from elin.scali.no ([62.70.89.10]:15634 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S313450AbSDQS64>;
	Wed, 17 Apr 2002 14:58:56 -0400
Date: Wed, 17 Apr 2002 20:58:52 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: Ingo Molnar <mingo@elte.hu>
cc: James Bourne <jbourne@MtRoyal.AB.CA>, <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Jeff Nguyen <jeff@aslab.com>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.44.0204171851020.5170-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0204172058300.31755-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Ingo Molnar wrote:

>
> On Wed, 17 Apr 2002, Steffen Persvold wrote:
>
> > Are any of these patches going into the mainline kernel soon ?
>
> my irqbalance patch is in Linus' tree already, it should show up in the
> next 2.5.9-pre kernel.
>

What about 2.4.x ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

