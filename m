Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVGMWBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVGMWBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVGMV5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:57:18 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:28353 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262585AbVGMV4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:56:21 -0400
X-ORBL: [63.202.173.158]
Date: Wed, 13 Jul 2005 14:56:01 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050713215601.GC12882@taniwha.stupidest.org>
References: <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <1121289881.4435.102.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121289881.4435.102.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 05:24:41PM -0400, Lee Revell wrote:

> Does anyone object to setting HZ at boot?  I suspect nothing else
> will make everyone happy.

Does it bloat the code or slow things measurably?
