Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWGWS3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWGWS3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWGWS3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:29:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750790AbWGWS3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:29:02 -0400
Date: Sun, 23 Jul 2006 11:23:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, dino@in.ibm.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       davej@redhat.com, ashok.raj@intel.com
Subject: Re: [PATCH] Cpuset: fix ABBA deadlock with cpu hotplug lock
In-Reply-To: <20060723111243.d1373616.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0607231122570.29649@g5.osdl.org>
References: <20060714095434.24283.5979.sendpatchset@jackhammer.engr.sgi.com>
 <20060723111243.d1373616.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jul 2006, Paul Jackson wrote:
> 
> Nine days ago, I offered this patch to fix a particular instance of
> ABBA deadlock we were seeing on a single customer machine,

"this patch"?

Can you resend the actual patch?

		Linus
