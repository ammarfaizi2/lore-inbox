Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291162AbSBSLFF>; Tue, 19 Feb 2002 06:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291214AbSBSLEz>; Tue, 19 Feb 2002 06:04:55 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:61385 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S291162AbSBSLEe>; Tue, 19 Feb 2002 06:04:34 -0500
Date: Tue, 19 Feb 2002 12:54:05 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Samium Gromoff <root@ibe.miee.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Ess Solo-1 interrupt behaviour
In-Reply-To: <200202191344.g1JDiUP12170@ibe.miee.ru>
Message-ID: <Pine.LNX.4.44.0202191252210.29620-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Samium Gromoff wrote:

>   Wait, wait, but my ISA Vibra 16 generates 20+ times less interrupts, with the
>   _same_ esd! 

Might have something to do with the way the driver handles things, sb 
being one of the better ones, i'm sure this was trawled around a couple 
months back Re: interrupt storm and emu10k1

Cheers,
	Zwane Mwaikambo


