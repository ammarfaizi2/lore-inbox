Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUDEWdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUDEW3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:29:52 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:4648
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S263571AbUDEW2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:28:20 -0400
thread-index: AcQbXZ4w+Rv1y4kjT/qsushoQ5kOJw==
X-Sieve: Server Sieve 2.2
From: "Hollis Blanchard" <hollisb@us.ibm.com>
To: <Administrator@vger.kernel.org>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
Date: Mon, 5 Apr 2004 23:30:37 +0100
Message-ID: <000001c41b5d$9e333100$d100000a@sbs2003.local>
User-Agent: KMail/1.5.3
Cc: "Sven Hartge" <hartge@ds9.gnuu.de>, <linux-kernel@vger.kernel.org>,
       "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
References: <20040329151515.GD2895@smtp.west.cox.net> <20040405155022.GL31152@smtp.west.cox.net> <4071CD50.2000402@g-house.de>
In-Reply-To: <4071CD50.2000402@g-house.de>
MIME-Version: 1.0
X-Mailer: Microsoft CDO for Exchange 2000
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Content-Class: urn:content-classes:message
Importance: normal
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-OriginalArrivalTime: 05 Apr 2004 22:30:37.0406 (UTC) FILETIME=[9E3F17E0:01C41B5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 05 April 2004 16:19, Christian Kujau wrote:
> um, yes. but the target "common_defconfig" was disabled somewhere in
> 2.5, so my shini script broke. i wanted to do common_defconfig first,
> then always keep my .config and do "oldconfig" after patching, but
> somehow my script broke, so i went with "allnoconfig"...but ok, i'll try
> again.

FWIW, I use ibmchrp_config and then enable a couple PReP-specific things. It's
pretty bare...

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


