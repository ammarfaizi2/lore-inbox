Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUGIUl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUGIUl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUGIUl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:41:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38303 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264236AbUGIUlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:41:11 -0400
Date: Fri, 9 Jul 2004 16:40:50 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Bryce Harrington <bryce@osdl.org>, <wli@holomorphy.com>,
       <ltp-list@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <testdev@osdl.org>
Subject: Re: [LTP] Re: Recent changes in LTP test results
In-Reply-To: <20040707230715.7a25c95c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0407091640300.4620-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Andrew Morton wrote:

> BTW, how long does a runalltests run take nowadays?  More than 90 minutes,
> that's for sure.  That's quite irritating...

Run with '-x 10' to run 10 tests in parallel ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

