Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSDQSzh>; Wed, 17 Apr 2002 14:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313312AbSDQSzg>; Wed, 17 Apr 2002 14:55:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49109 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313307AbSDQSzf>;
	Wed, 17 Apr 2002 14:55:35 -0400
Date: Wed, 17 Apr 2002 18:51:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Steffen Persvold <sp@scali.com>
Cc: James Bourne <jbourne@MtRoyal.AB.CA>, <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Jeff Nguyen <jeff@aslab.com>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.30.0204172050410.31755-100000@elin.scali.no>
Message-ID: <Pine.LNX.4.44.0204171851020.5170-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Apr 2002, Steffen Persvold wrote:

> Are any of these patches going into the mainline kernel soon ?

my irqbalance patch is in Linus' tree already, it should show up in the
next 2.5.9-pre kernel.

	Ingo

