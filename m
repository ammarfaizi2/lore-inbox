Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUJGJrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUJGJrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269779AbUJGJrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:47:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64918 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266349AbUJGJoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:44:13 -0400
Date: Thu, 7 Oct 2004 02:41:45 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: mbligh@aracnet.com, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041007024145.4918bcc1.pj@sgi.com>
In-Reply-To: <1097104915.4907.99.camel@arrakis>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
	<20041005193953.6edc83b2.pj@sgi.com>
	<1097104915.4907.99.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> I'm really glad to hear that, Paul.  That unconstrained (ab)use was my
> only real concern with the cpusets patches.  I look forward to massaging
> our two approaches into something that will satisfy all interested
> parties.

Sounds good.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
