Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWJJVl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWJJVl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWJJVl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:41:59 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:30769 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965022AbWJJVl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:41:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CALSuK0U
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="1857367019:sNHT28808204"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, tim.c.chen@linux.intel.com,
       Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
X-Message-Flag: Warning: May contain useful information
References: <B41635854730A14CA71C92B36EC22AAC3F4CAB@mssmsx411>
	<Pine.LNX.4.58.0610101712370.10398@gandalf.stny.rr.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 14:41:51 -0700
In-Reply-To: <Pine.LNX.4.58.0610101712370.10398@gandalf.stny.rr.com> (Steven Rostedt's message of "Tue, 10 Oct 2006 17:17:38 -0400 (EDT)")
Message-ID: <adapsczdf1c.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Oct 2006 21:41:53.0048 (UTC) FILETIME=[E667F980:01C6ECB4]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Steven> In todays world, SMP is becoming more and more common
    Steven> (still waiting to get that DualCore cell phone).

A digression -- but most "smart" phones these days actually are dual
core, although not SMP -- typically one core will run the DSP-type
stuff for actually being a phone while the other core will run a more
general-purpose OS for the fancy UI and "smart" apps.

 - R.
