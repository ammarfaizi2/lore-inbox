Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSCWBYU>; Fri, 22 Mar 2002 20:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292131AbSCWBXM>; Fri, 22 Mar 2002 20:23:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292841AbSCWBPO>;
	Fri, 22 Mar 2002 20:15:14 -0500
Date: Fri, 22 Mar 2002 23:51:49 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
To: <arjan@fenrus.demon.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Interrupts lost on Intel Plumas chipset
In-Reply-To: <200203222232.g2MMWsY02827@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.30.0203222344020.4279-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002 arjan@fenrus.demon.nl wrote:

> In article <3C9BAB3D.C66B7AAE@scali.com> you wrote:
> > List readers,
> >
> > I have a SuperMicro P4DPR+ system here with Dual Intel Xeon 1.7GHz. This board utilizes the Intel
> > E7500 (Plumas) chipset. The chipset is configured with two P64H2 (PCI-X) Hubs, one which is
> > kernel-2.4.9-21smp (and I've also tried a stock 2.4.17 kernel), interrupts from the SCI card never
>
> You need at least kernel-2.4.9-31smp or 2.4.18 for the plumas chipset to
> work properly

Why ? I haven't seen anything specific in the changelogs ? What is
missing in 2.4.17 ? Is it the APIC stuff that isn't implemented good
enough ( I see something about APIC LVTERR) ?

Regards,

-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

