Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVGMXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVGMXor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVGMXoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:44:04 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:24292 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261208AbVGMXlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:41:42 -0400
Date: Wed, 13 Jul 2005 16:41:41 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050713211650.GA12127@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz>
 <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
 <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
 <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com>
 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
 <20050713211650.GA12127@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Chris Wedgwood wrote:

> On Wed, Jul 13, 2005 at 01:48:57PM -0700, Andrew Morton wrote:
> > "My expectation is if we want to beat the competition, we'll want
> > the ability to go *under* 100Hz."
> 
> What does Windows do here?

windows xp base rate is 100Hz... but multimedia apps can ask for almost 
any rate they want (depends on the hw capabilities).  i recall seeing 
rates >1200Hz when you launch some of the media player apps -- sorry i 
forget the exact number.

i don't think it goes slower than 100Hz.

-dean
