Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbTBTNJp>; Thu, 20 Feb 2003 08:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTBTNJp>; Thu, 20 Feb 2003 08:09:45 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:49840 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265880AbTBTNJo>;
	Thu, 20 Feb 2003 08:09:44 -0500
Date: Thu, 20 Feb 2003 13:31:40 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62
Message-ID: <20030220133140.GA13507@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Zilvinas Valinskas <zilvinas@gemtek.lt>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com> <3E536237.8010502@blue-labs.org> <20030219185017.GA6091@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219185017.GA6091@gemtek.lt>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 08:50:17PM +0200, Zilvinas Valinskas wrote:
 > it might triple fault ? Who knows. One thing I am sure of, if I don't
 > load agpgart + intel-agp, laptop in questions, works flawlessly.
 > Otherwise first time I log of KDE trying to login as different user I
 > get instant reboot.

Ok, there were quite a few changes in that area in .61.
Can you check .60 was ok, and .61 crashes the same way ?
If .61 is ok, agp is a red-herring, as it didnt change in .62

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
