Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUJ0E33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUJ0E33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUJ0E33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:29:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261495AbUJ0E3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:29:24 -0400
Date: Wed, 27 Oct 2004 00:29:10 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
cc: Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
In-Reply-To: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>
Message-ID: <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Marcos D. Marado Torres wrote:

> When it happened in 2.4 2.5 was created. Isn't all this just the
> indication that we need a 2.6 development like 2.4 is, and we need 2.7
> to be created?

While a 2.7 series might provide developers with an "outlet"
for their creativity, it does not give users the availability
of the features they need.

Most features are developed because a user needs them now,
so having the users wait until 2.8 is not acceptable.  Making
the distributions backport the needed features into 2.6 leads
to lots of duplicate effort and some code fragmentation.

I like the way 2.6 is currently being handled.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

