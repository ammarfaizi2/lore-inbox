Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVGMV0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVGMV0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVGMVZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:25:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25817 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262476AbVGMVYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:24:43 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <20050713211650.GA12127@taniwha.stupidest.org>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz>
	 <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 17:24:41 -0400
Message-Id: <1121289881.4435.102.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 14:16 -0700, Chris Wedgwood wrote:
> Both can be detected from you .config and we could see HZ as needed
> there and everyone else could avoid this surely?

Does anyone object to setting HZ at boot?  I suspect nothing else will
make everyone happy.

Lee

