Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTBDPhW>; Tue, 4 Feb 2003 10:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTBDPhW>; Tue, 4 Feb 2003 10:37:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5770 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267277AbTBDPhV>; Tue, 4 Feb 2003 10:37:21 -0500
Date: Tue, 04 Feb 2003 07:46:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bryan Andersen <bryan@bogonomicon.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <171670000.1044373604@[10.10.2.4]>
In-Reply-To: <3E3F8DE6.708@bogonomicon.net>
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
 <200302040656.h146uJs10531@Port.imtp.ilyichevsk.odessa.ua>
 <3E3F8DE6.708@bogonomicon.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Personal opinion here but I know it is also held by many developers I
> know and work with.  I'd rather have a compiler that produces correct and
> fast code but ran slow than one that produces slow or bad code and runs
> fast.  Remember compilation is done far less often than run time
> execution.  

Yeah, I'd make that tradeoff too, but gcc 3.2 doesn't give me that.
People keep saying it does, but I see no real evidence of it.
Show me the money.

M.
