Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUJDRHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUJDRHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUJDRHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:07:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:33933 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268281AbUJDRHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:07:09 -0400
Date: Mon, 4 Oct 2004 09:46:39 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: efocht@hpce.nec.com, akpm@osdl.org, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041004094639.076c65e7.pj@sgi.com>
In-Reply-To: <842970000.1096901859@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200410032221.26683.efocht@hpce.nec.com>
	<20041003134842.79270083.akpm@osdl.org>
	<200410041605.30395.efocht@hpce.nec.com>
	<842970000.1096901859@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> I don't think anyone is suggesting that either system as is could replace
> the other ... more that a combined system could be made for both types
> of resource control that would be a better overall solution.

Oops - sorry, Martin.  I obviously didn't read your entire sentence
before objecting before.

Now that I do, it makes sense.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
