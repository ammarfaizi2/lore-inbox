Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUJGSah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUJGSah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUJGS2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:28:35 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:40109 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S267708AbUJGS2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:28:12 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
References: <200410071318.21091.mbuesch@freenet.de>
	<20041007151518.GA14614@logos.cnet>
	<200410071917.40896.mbuesch@freenet.de>
	<20041007153929.GB14614@logos.cnet>
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Thu, 07 Oct 2004 20:28:04 +0200
Message-ID: <x67jq2bcy3@gzp>
User-Agent: Gnus/5.110003 (No Gnus v0.3)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo.tosatti@cyclades.com>:

| > > Can you check how much swap space is there available when
| > > the OOM killer trigger? I bet this is the case.
| > 
| > The machine doesn't have swap.
| 
| Well then you're probably facing true OOM.
| 
| Add some swap.

There is really no way to run 2.4 without swap?

I have the same problem with nfsroot and ramdisk based setups after
1-2 weeks uptime.
