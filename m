Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbSJGFSc>; Mon, 7 Oct 2002 01:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262869AbSJGFSc>; Mon, 7 Oct 2002 01:18:32 -0400
Received: from adsl-216-62-201-42.dsl.austtx.swbell.net ([216.62.201.42]:45440
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S262868AbSJGFSa>; Mon, 7 Oct 2002 01:18:30 -0400
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
In-Reply-To: <3DA11884.7050004@metaparadigm.com>
References: <200210061103.g96B3mlO001484@darkstar.example.net>
	 <3DA02BF2.2040506@metaparadigm.com>  <1033933235.2436.1.camel@localhost>
	 <1033946058.2436.13.camel@localhost> <1033966448.1512.2.camel@localhost>
	 <3DA11884.7050004@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1033968242.3948.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 07 Oct 2002 00:24:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 00:15, Michael Clark wrote:

> So sparse lun scanning is working then - sounds like your missing luns
> is a problem with your array configuration as the kernel is probing them
> (if it is was creating the even ones) - means the qlogic driver must
> not be able to see these luns. Not familiar with your array so can't
> help any more - your array vendor would probably be the most help.
> 
> ~mc
> 

Seems so. The odd thing is, that the hba1, vs. hba0, is not listed as
seeing any LUNs just existing. I'll go back and re-check my config. My
DSL really sux ATM, so doing things through X sessions has been a bit
painful. 

--The GrandMaster
