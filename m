Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVGMVic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVGMVic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVGMVfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:35:55 -0400
Received: from dvhart.com ([64.146.134.43]:60598 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262767AbVGMVfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:35:40 -0400
Date: Wed, 13 Jul 2005 14:35:32 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Lee Revell <rlrevell@joe-job.com>, Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <370240000.1121290532@flay>
In-Reply-To: <1121289881.4435.102.camel@mindpipe>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <1121289881.4435.102.camel@mindpipe>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, July 13, 2005 17:24:41 -0400 Lee Revell <rlrevell@joe-job.com> wrote:

> On Wed, 2005-07-13 at 14:16 -0700, Chris Wedgwood wrote:
>> Both can be detected from you .config and we could see HZ as needed
>> there and everyone else could avoid this surely?
> 
> Does anyone object to setting HZ at boot?  I suspect nothing else will
> make everyone happy.

Having the option is good ... the same arguments about creating a sensible
default still applies though (whatever that is). Creating yet more frigging
tunables for users to manage is not really a good way out ...

M.

