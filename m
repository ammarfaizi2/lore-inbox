Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSECQN3>; Fri, 3 May 2002 12:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314498AbSECQN2>; Fri, 3 May 2002 12:13:28 -0400
Received: from mail.interware.hu ([195.70.32.130]:24809 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP
	id <S314483AbSECQN1>; Fri, 3 May 2002 12:13:27 -0400
Date: Fri, 3 May 2002 18:13:26 +0200 (CEST)
From: Hirling Endre <endre@interware.hu>
To: Russell Leighton <russ@elegant-software.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 as a router, when is it appropriate?
In-Reply-To: <3CD28FB8.40204@elegant-software.com>
Message-ID: <Pine.LNX.4.44.0205031806480.12310-100000@dusk.interware.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 May 2002, Russell Leighton wrote:

> Could someone please tell me (or refer me to docs) on when
> using the Linux on PC hardware as a router is an appropriate
> solution and when one should consider a "real" router (e.g., Cisco)?

I have a Linux-based router and it can handle about as much as a cisco
7206vxr with GE interfaces. I think both of them reaches the bandwidth
limit of the PCI bus. The PC can be much better with 64bit/66MHz PCI
buses or you can even buy motherboards with 100 or 133MHz PCI-X slots. I
guess those can drive 3 or 4 GE interfaces at gigabit speed.

You need a cisco when you care about interface density, you have
interfaces you can't buy for a PC or you need to route protocols other
than IP or proprietary to cisco.

endre

