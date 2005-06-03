Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVFCTH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVFCTH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVFCTH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:07:59 -0400
Received: from webmail.topspin.com ([12.162.17.3]:38418 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261209AbVFCTHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:07:50 -0400
To: Nathan Lynch <ntl@pobox.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       ppc64 dev list <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.12-rc5-git8 regression on PPC64
X-Message-Flag: Warning: May contain useful information
References: <374360000.1117810369@[10.10.2.4]> <52is0vwd49.fsf@topspin.com>
	<20050603182725.GB11355@otto>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 03 Jun 2005 12:07:46 -0700
In-Reply-To: <20050603182725.GB11355@otto> (Nathan Lynch's message of "Fri,
 3 Jun 2005 13:27:25 -0500")
Message-ID: <52vf4vuum5.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Jun 2005 19:07:46.0879 (UTC) FILETIME=[87320CF0:01C5686F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Nathan> Backing this one out fixes it here on a Power5 570.

    Nathan> http://marc.theaimsgroup.com/?l=bk-commits-head&m=111772917211270&q=raw

This fixes the boot on an OpenPower 710 for me as well.

Thanks,
  Roland
