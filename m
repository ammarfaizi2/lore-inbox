Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVEDB3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVEDB3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 21:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEDB3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 21:29:48 -0400
Received: from animx.eu.org ([216.98.75.249]:57992 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261964AbVEDB3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 21:29:47 -0400
Date: Tue, 3 May 2005 21:29:10 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: shogunx <shogunx@sleekfreak.ath.cx>
Cc: segin <segin11@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: zImage on 2.6?
Message-ID: <20050504012910.GC13360@animx.eu.org>
Mail-Followup-To: shogunx <shogunx@sleekfreak.ath.cx>,
	segin <segin11@yahoo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050503223148.GF12199@animx.eu.org> <Pine.LNX.4.44.0505032026360.1510-100000@sleekfreak.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0505032026360.1510-100000@sleekfreak.ath.cx>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shogunx wrote:
> On Tue, 3 May 2005, Wakko Warner wrote:
> 
> On an interesting side note, when running linux on IBM rs/6000, which is
> a ppc64 machine, one must use a zImage kernel dd'ed into a small PReP
> partition to boot the machine... bzImage kernels will not work.

Some time ago, I thought they decided to make zImage = bzImage.  That was
going through my mind when I tried "make zImage" and was actually surprised
it didn't work.

So I guess for some arches (x86 in this case) they could either make zImage
= bzImage or just remove it.  Although I'm not sure how many people actually
try it anymore =)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
