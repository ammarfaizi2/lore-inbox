Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSHVXeS>; Thu, 22 Aug 2002 19:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSHVXeS>; Thu, 22 Aug 2002 19:34:18 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63988 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318059AbSHVXeS>; Thu, 22 Aug 2002 19:34:18 -0400
Subject: Re: 3Ware ok 2.4.19, dies 2.4.19-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: brian@worldcontrol.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020822231034.GA4538@top.worldcontrol.com>
References: <20020822231034.GA4538@top.worldcontrol.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 00:39:48 +0100
Message-Id: <1030059588.3161.103.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 00:10, brian@worldcontrol.com wrote:
> I upgraded a machine with a 3ware RAID controller running 2.2.20 to 
> 2.4.19-ac1.  The next day it lay dead.  On the screen was a
> message about 3ware: AEN overflow.
> 
> I upgraded to 2.4.19-ac4.  24 hours later the same message was on
> the screen.
> 
> I downgraded to 2.4.19 and have had 7 days of uptime.
> 
> The load on the machine is very constant.
> 
> I've can't say I've done enough testing to confirm that its an ac
> issue.  Just something I came across.

Same code in both. Thanks for the report though. 

