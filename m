Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSJNPqY>; Mon, 14 Oct 2002 11:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbSJNPqY>; Mon, 14 Oct 2002 11:46:24 -0400
Received: from ausadmmsps305.aus.amer.dell.com ([143.166.224.100]:3852 "HELO
	AUSADMMSPS305.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S261934AbSJNPqW>; Mon, 14 Oct 2002 11:46:22 -0400
X-Server-Uuid: bc938b4d-8e35-4c08-ac42-ea3e606f44ee
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E9A1@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: rob@osinvestor.com, davej@codemonkey.org.uk, wim@iguana.be,
       rddunlap@osdl.org, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: RE: Watchdog drivers
Date: Mon, 14 Oct 2002 10:51:59 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11B437A22145710-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, I've got patches around from Matt Domsch that did the 
> move, and changed
> around the necessary drivers/char/ files.  I haven't been 
> keeping them up-to- date, maybe Matt has.

I haven't been, but it doesn't look too painful to do it.  The Natsemi
SCx200 merge is what's screwing up BK's automerge of it (I hadn't updated
that tree since April...).

The move work took me a few hours last time I did it, I can resurrect that
now that there's interest.  Give me a few hours, today's kind of busy...

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

