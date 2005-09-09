Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVIIAzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVIIAzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 20:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVIIAzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 20:55:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17870 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751391AbVIIAzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 20:55:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, "Ronny V. Vindenes" <s864@ii.uib.no>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.13-mm2
In-Reply-To: Parag Warudkar's message of  Thursday, 8 September 2005 20:26:51 -0400 <4320D6CB.2030707@comcast.net>
X-Zippy-Says: Dizzy, are we "REAL PEOPLE" or "AMAZING ANIMALS"?
Message-Id: <20050909005512.74119180A14@magilla.sf.frob.com>
Date: Thu,  8 Sep 2005 17:55:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess something else has changed since I tested the patch.  I haven't
tried -mm2, but the current Linus tree I'm having trouble getting to boot
on my x86_64 machine atm ("soft lockup" in the e1000 driver setup).


Thanks,
Roland
