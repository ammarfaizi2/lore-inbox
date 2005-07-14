Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVGNOU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVGNOU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVGNOU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:20:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28133 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263032AbVGNOUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:20:54 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <Pine.LNX.4.61.0507141118580.18072@yvahk01.tjqt.qr>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz>
	 <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <42D5ACCE.30504@vc.cvut.cz>
	 <Pine.LNX.4.61.0507141118580.18072@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 10:20:53 -0400
Message-Id: <1121350854.4535.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 11:24 +0200, Jan Engelhardt wrote:
> >>>> "My expectation is if we want to beat the competition, we'll want
> >>>> the ability to go *under* 100Hz."
> >>> 
> >>> What does Windows do here?
> >>
> >> windows xp base rate is 100Hz... but multimedia apps can ask for almost 
> >
> > 83Hz
> 
> Well, Windoes 98 (vmmon) shows very different ones:

Wow.  Windows has been doing this since *98*?

So that's what Paul meant by "the stupidity of a fixed HZ, which is so
early '90s that its embarrassing".

Lee

