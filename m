Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292850AbSCOQHm>; Fri, 15 Mar 2002 11:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292846AbSCOQHc>; Fri, 15 Mar 2002 11:07:32 -0500
Received: from ausxc08.us.dell.com ([143.166.227.176]:14342 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S292850AbSCOQHU>; Fri, 15 Mar 2002 11:07:20 -0500
Message-ID: <71714C04806CD51193520090272892170452B462@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: dmarkh@cfl.rr.com, linux-kernel@vger.kernel.org
Cc: markh@compro.net
Subject: RE: Advanced Programmable Interrupt Controller (APIC)?
Date: Fri, 15 Mar 2002 10:06:22 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now I've
> also heard that DELL does not properly setup the APIC chip in
> the bios because MS os's don't use it. Have no idea if this 
> is true or not. 

To the best of my knowledge, BIOS and Linux work together to set up the
APICs properly on the PowerEdge 6400 (and all our other servers too).  If
someone has proof that we don't, and what should be done instead, please let
me know.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001! (IDC Mar 2002)
