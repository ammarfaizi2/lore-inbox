Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVADS5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVADS5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVADS5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:57:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43428 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261697AbVADS5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:57:17 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>
In-Reply-To: <20050104182010.GA15254@infradead.org>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 13:57:13 -0500
Message-Id: <1104865034.8346.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 18:20 +0000, Christoph Hellwig wrote:
> On Tue, Jan 04, 2005 at 01:16:54PM -0500, Lee Revell wrote:
> > Got a patch?  Code talks, BS walks.  This is working perfectly, right
> > now, and is being used by thousands of Linux ausio users.
> 
> Which still doesn't mean it's the right design.  And no, I don't need the
> feature so I won't write it.  If you want a certain feature it's up to
> you to implement it in a way that's considered mergeable.
> 

Please specify what's wrong with it.  So far all your objection amounts
to is "I don't like it".

If you do have anything other that your opinion to back up your
assertion that it's a bad design, you should have raised it months ago
when this was first posted.  Now that we have it to a mergeable state
(as far as the people who worked on it are concerned), you want to pop
up and say "Nope, bad design"?

Sorry but last time I checked you were not the ultimate arbiter of good
design on LKML.  If you want to shitcan the _only known good, field
tested, working solution_ then you have to have overwhelming technical
arguments.  So far I've seen zero.

Lee

