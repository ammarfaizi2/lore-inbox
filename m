Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVBIA2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVBIA2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVBIA2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:28:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48272 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261716AbVBIA14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:27:56 -0500
Date: Tue, 8 Feb 2005 16:27:05 -0800
From: Paul Jackson <pj@sgi.com>
To: nagar@watson.ibm.com
Cc: colpatch@us.ibm.com, dino@in.ibm.com, mbligh@aracnet.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20050208162705.351b4543.pj@sgi.com>
In-Reply-To: <42095222.5010700@watson.ibm.com>
References: <20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
	<420800F5.9070504@us.ibm.com>
	<20050208095440.GA3976@in.ibm.com>
	<42090C42.7020700@us.ibm.com>
	<20050208124234.6aed9e28.pj@sgi.com>
	<420939B6.7010608@us.ibm.com>
	<42095222.5010700@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> Well, I'm not sure I want to minutely examine Paul's choice of words !

You're a wise man ;).


> Rereading the earlier posts on the thread, I'd agree. There are some 
> similarities in our interfaces but not enough to warrant a merger.

As I said ... a wise man !

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
