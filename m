Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbTAIQh4>; Thu, 9 Jan 2003 11:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266851AbTAIQh4>; Thu, 9 Jan 2003 11:37:56 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:65259 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266849AbTAIQh4>;
	Thu, 9 Jan 2003 11:37:56 -0500
Date: Thu, 9 Jan 2003 16:44:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] PATCH: IPMI driver
Message-ID: <20030109164407.GA26195@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	alan@lxorguk.ukuu.org.uk
References: <200301090332.h093WML05981@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301090332.h093WML05981@hera.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > ChangeSet 1.980, 2003/01/08 22:23:15-02:00, alan@lxorguk.ukuu.org.uk
 > 
 > 	[PATCH] PATCH: IPMI driver
 > 	
 > 	This has been in -ac for a short while. Linus accepted and merged the
 > 	same IPMI support into 2.5.54 so now it can move into 2.4 IMHO
 > 
 >  Documentation/IPMI.txt              |  341 ++++++
 >  drivers/char/Makefile               |    5 
 >  drivers/char/ipmi/Makefile          |   20 
 >  drivers/char/ipmi/ipmi_devintf.c    |  532 ++++++++++
 >  drivers/char/ipmi/ipmi_kcs_intf.c   | 1235 ++++++++++++++++++++++++
 >  drivers/char/ipmi/ipmi_kcs_sm.c     |  467 +++++++++
 >  drivers/char/ipmi/ipmi_kcs_sm.h     |   70 +
 >  drivers/char/ipmi/ipmi_msghandler.c | 1811 ++++++++++++++++++++++++++++++++++++
 >  drivers/char/ipmi/ipmi_watchdog.c   |  971 +++++++++++++++++++
 >  include/linux/ipmi.h                |  516 ++++++++++
 >  include/linux/ipmi_msgdefs.h        |   58 +
 >  include/linux/ipmi_smi.h            |  144 ++
 >  12 files changed, 6170 insertions(+)

Either I'm blind, or none of those files exist in Linus' tree
looking at current bitkeeper snapshot.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
