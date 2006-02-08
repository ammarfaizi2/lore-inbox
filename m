Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWBHMCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWBHMCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWBHMCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:02:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5521 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965006AbWBHMCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:02:14 -0500
Subject: Re: libata PATA status report on 2.6.16-rc1-mm5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <33D367D1-870E-46AE-A7EC-C938B51E816F@bootc.net>
References: <33D367D1-870E-46AE-A7EC-C938B51E816F@bootc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Feb 2006 12:04:38 +0000
Message-Id: <1139400278.26270.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-08 at 09:58 +0000, Chris Boot wrote:
> and everything seems to work fine. I notice PATA CD-ROMs still aren't  
> being recognised (with libata.atapi_enabled=1) which is a bit of a  
> shame, but fortunately I won't be needing to use the CD-ROM on this  
> machine at all. In fact this machine has so little use that I'm quite  
> happy to surrender it to testing.

What ports are the CDROM devices attached to. I'd expect to see them
found and reported as "being ignored" so it may indicate a bigger
problem.


