Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310544AbSCLKJq>; Tue, 12 Mar 2002 05:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310546AbSCLKJg>; Tue, 12 Mar 2002 05:09:36 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:54190 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310544AbSCLKJY>; Tue, 12 Mar 2002 05:09:24 -0500
Date: Tue, 12 Mar 2002 11:52:40 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Gunther Mayer <gunther.mayer@gmx.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
In-Reply-To: <3C8D0447.2030404@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203121148010.22809-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Martin Dalecki wrote:

> buffer overruns... methods called twice and modularization as well
> as comments about functions passing timeout pointers, which are
> taken by reusing the IRQ code path and so on...

Are you referring to the IDE-CD code there? If so can you show me where 
the timeout handler uses the ISRs? And what exactly is wrong with the 
timeout handlers anyway?

Regards,
	Zwane Mwaikambo



