Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269012AbTCAUAD>; Sat, 1 Mar 2003 15:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269014AbTCAT7D>; Sat, 1 Mar 2003 14:59:03 -0500
Received: from dp.samba.org ([66.70.73.150]:11752 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269011AbTCAT67>;
	Sat, 1 Mar 2003 14:58:59 -0500
Date: Sat, 1 Mar 2003 20:31:09 +1100
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       zilvinas@gemtek.lt, helgehaf@aitel.hist.no,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2.5.62-mm3] objrmap fix for X
Message-ID: <20030301093109.GF2606@krispykreme>
References: <20030223230023.365782f3.akpm@digeo.com> <40780000.1046240068@[10.10.2.4]> <14910000.1046281932@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14910000.1046281932@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Pah. Debian stealth-upgraded me to gcc 3.2 ... no wonder it's slow as a
> dog. So your patch is stable, and works just fine. Sorry,

Yep, gcc-2.95 -> gcc-3.2 dropped SDET results by about 10% on my ppc64
boxes :(

Anton
