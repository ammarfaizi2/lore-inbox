Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVKDTtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKDTtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 14:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVKDTtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 14:49:19 -0500
Received: from outbound04.telus.net ([199.185.220.223]:51357 "EHLO
	priv-edtnes27.telusplanet.net") by vger.kernel.org with ESMTP
	id S1750795AbVKDTtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 14:49:19 -0500
From: Andi Kleen <ak@suse.de>
To: "Brunner, Richard" <richard.brunner@amd.com>
Subject: Re: TSC and Power Management Events on AMD Processors
Date: Fri, 4 Nov 2005 20:49:11 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, "Langsdorf, Mark" <mark.langsdorf@amd.com>
References: <C2BC72CDFC11A44083B660CAC2E9EA67032328C7@SAUSEXMB1.amd.com>
In-Reply-To: <C2BC72CDFC11A44083B660CAC2E9EA67032328C7@SAUSEXMB1.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511042049.11407.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 17:36, Brunner, Richard wrote:
> Thought you might find this note useful ...

Thanks Richard for posting this useful overview.
As a short note mainline 2.6 Linux should be all fine regarding
its use of TSC vs HPET vs PMTIMER on current AMD systems.

-Andi
