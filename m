Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVGNAz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVGNAz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVGNAyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:54:04 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:64643 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261379AbVGNAvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:51:31 -0400
X-ORBL: [63.202.173.158]
Date: Wed, 13 Jul 2005 17:51:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050714005106.GA16085@taniwha.stupidest.org>
References: <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 04:41:41PM -0700, dean gaudet wrote:

> windows xp base rate is 100Hz... but multimedia apps can ask for
> almost any rate they want (depends on the hw capabilities).  i
> recall seeing rates >1200Hz when you launch some of the media player
> apps -- sorry i forget the exact number.

Windows starts an additional high-speed timer as needed for this?
