Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWG0HsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWG0HsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWG0HsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:48:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23465 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751299AbWG0HsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:48:23 -0400
Message-ID: <44C86FB9.6090709@redhat.com>
Date: Thu, 27 Jul 2006 03:48:09 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: use-once cleanup
References: <1153168829.31891.89.camel@lappy>
In-Reply-To: <1153168829.31891.89.camel@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Hi,
> 
> This is yet another implementation of the PG_useonce cleanup spoken of
> during the VM summit.

After getting bitten by rsync yet again, I guess it's time to insist
that this patch gets merged...

Andrew, could you merge this?  Pretty please? ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
