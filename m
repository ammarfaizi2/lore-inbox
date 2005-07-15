Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263337AbVGOQzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbVGOQzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbVGOQze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:55:34 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:49839 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S263337AbVGOQzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:55:10 -0400
X-ORBL: [63.202.173.158]
Date: Fri, 15 Jul 2005 09:54:31 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715165431.GA22479@taniwha.stupidest.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 12:33:15PM -0400, Brown, Len wrote:

> So, the 13-year-old design advice will continue to apply to
> 13-year-old systems, but newer systems with C3 and HPET
> should be using them.

Last I looked HPET isn't everywhere yet (absent from nforce4
mainboards for example, but that might be a linux issue as I was told
window can see one).
