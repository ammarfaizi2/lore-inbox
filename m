Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTBDRt3>; Tue, 4 Feb 2003 12:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267309AbTBDRt3>; Tue, 4 Feb 2003 12:49:29 -0500
Received: from franka.aracnet.com ([216.99.193.44]:33423 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267308AbTBDRt2>; Tue, 4 Feb 2003 12:49:28 -0500
Date: Tue, 04 Feb 2003 09:55:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: gcc 2.95 vs 3.21 performance
Message-ID: <186500000.1044381340@[10.10.2.4]>
In-Reply-To: <20030204094041.A25052@beaverton.ibm.com>
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
 <200302040656.h146uJs10531@Port.imtp.ilyichevsk.odessa.ua>
 <162450000.1044342810@[10.10.2.4]> <20030204122536.GV6915@fs.tum.de>
 <173250000.1044373915@[10.10.2.4]> <177230000.1044376046@[10.10.2.4]>
 <20030204094041.A25052@beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Speaking of which, has anyone ever compiled the ia32 Linux kernel with
>> the Intel compiler? I thought I saw some patches floating around to make
>> it compile the ia64 kernel .... that'd be an interesting test case ...
>> might give us some ideas about what could be tweaked in GCC (or code
>> rejiggled in the kernel).
>> 
>> M.
> 
> Martin -
> 
> Like this?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103559880923586&w=2

Yeah, something very like that ;-) Thanks.
Preferably less micro-benchmarky though ....

M.

