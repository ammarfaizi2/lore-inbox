Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbTANEfc>; Mon, 13 Jan 2003 23:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbTANEfa>; Mon, 13 Jan 2003 23:35:30 -0500
Received: from franka.aracnet.com ([216.99.193.44]:1502 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267452AbTANEf3>; Mon, 13 Jan 2003 23:35:29 -0500
Date: Mon, 13 Jan 2003 20:43:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>
cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Message-ID: <350360000.1042519436@titus>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C022BD8F1@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C022BD8F1@usslc-exch-4.slc.unisys.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> True - it has to be only done once per CPU bring-up.
> 
> To investigate all the corners of this issue: is it possible now, tomorrow,
> on in the future to mix Intel processors on the same machine? 

Yes. We can mix PPro 180s up with P3 900s, for a long time now.

> enough really to collect the APIC version of boot CPU and just use it for
> the rest? 

Nope. 

M.

