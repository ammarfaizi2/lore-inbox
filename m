Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSGCObS>; Wed, 3 Jul 2002 10:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSGCObS>; Wed, 3 Jul 2002 10:31:18 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:28840 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317022AbSGCObR>; Wed, 3 Jul 2002 10:31:17 -0400
Date: Wed, 3 Jul 2002 16:02:06 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Yaroslav Popovitch <yp@sot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: which device nodes used by  ips.o module?
In-Reply-To: <Pine.LNX.4.44.0207031659420.2228-100000@ares.sot.com>
Message-ID: <Pine.LNX.4.44.0207031601120.20478-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002, Yaroslav Popovitch wrote:

> 
> I could not find information about device nodes which are used by ips.o 
> module(IBM ServeRAID 4Mx).
> I don't have hardware, as result I cannot check in experiment.
> Would you help me ...

By device nodes do you mean /dev/foo? In which case its just 
/dev/sd[abc...]

Cheers,
	Zwane

-- 
http://function.linuxpower.ca
		

