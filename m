Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269315AbUJKWpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269315AbUJKWpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUJKWpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:45:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28076 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269315AbUJKWp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:45:28 -0400
Date: Mon, 11 Oct 2004 15:42:29 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: frankeh@watson.ibm.com, ricklind@us.ibm.com, mbligh@aracnet.com,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] Re: [PATCH] cpusets - big numa cpu and memory
 placement
Message-Id: <20041011154229.7e850ad2.pj@sgi.com>
In-Reply-To: <1097532989.4038.61.camel@arrakis>
References: <20041007015107.53d191d4.pj@sgi.com>
	<200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	<20041007072842.2bafc320.pj@sgi.com>
	<4165A31E.4070905@watson.ibm.com>
	<20041008061426.6a84748c.pj@sgi.com>
	<4166B569.60408@watson.ibm.com>
	<20041008112319.63b694de.pj@sgi.com>
	<1097283613.6470.146.camel@arrakis>
	<20041009130808.70c56ea3.pj@sgi.com>
	<1097532989.4038.61.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthrew wrote:
> My (completely uninformed) guess is that the CKRM folks thought it would
> be extremely unlikely to be able to get the 'vrm' into the kernel
> without something to use it.

I'd guess the same thing.

> The 'vrm' and the fair share scheduler, should be
> logically separate pieces of code, though. 

I agree - should be.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
