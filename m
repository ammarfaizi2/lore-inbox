Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSGCPby>; Wed, 3 Jul 2002 11:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSGCPbx>; Wed, 3 Jul 2002 11:31:53 -0400
Received: from ns.suse.de ([213.95.15.193]:19717 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317030AbSGCPbv>;
	Wed, 3 Jul 2002 11:31:51 -0400
Date: Wed, 3 Jul 2002 17:34:21 +0200
From: Dave Jones <davej@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
Message-ID: <20020703173421.B8934@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020701140915.23920A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020701140915.23920A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Jul 01, 2002 at 02:25:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 02:25:16PM -0400, Bill Davidsen wrote:
 > I suggested that 2.5 be opened when 2.4 came out, so I like the idea of
 > 2.7 starting when 2.6 is released. I think developers will maintain the
 > 2.6 work out of pride and desire to have a platform for the "next big
 > thing." And their code can always be placed on hold for 2.7 until they
 > clarify their thinking on 2.6, if that's really needed.

Unfortunatly, there's the possibility of people thinking
"I'll fix it properly in 2.7, and backport", during which time,
2.6 doesn't get fixed any faster.  People diving into 2.7 development
and leaving 2.6 to those that actually care about stabilising it was
Linus' concern if I understood correctly at the summit.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
