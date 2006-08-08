Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWHHKPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWHHKPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWHHKPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:15:16 -0400
Received: from stingr.net ([212.193.32.15]:8832 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S964787AbWHHKPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:15:14 -0400
Date: Tue, 8 Aug 2006 14:15:04 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
Message-ID: <20060808101504.GJ2152@stingr.net>
Mail-Followup-To: Thomas Stewart <thomas@stewarts.org.uk>,
	linux-kernel@vger.kernel.org
References: <20060808082429.GA1068@stewarts.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060808082429.GA1068@stewarts.org.uk>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Thomas Stewart:
> Hi,
> I have a Dell Optiplex GX280, a Pentium 4 with an Intel chipset. It has
> 4G of ram. The problem is I can only see 3.2G, even tho the bios reports
> 4G.

Chipset issue. Some Intel chipsets are doing strange things with memory
map. They call this "design flaw" but not offered free replacements
yet, so, for example, on SE7221BK1E you can't use more than 3 gigs.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
