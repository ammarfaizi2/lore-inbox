Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVDKRwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVDKRwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVDKRwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:52:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50820 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261848AbVDKRwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:52:09 -0400
Date: Mon, 11 Apr 2005 10:50:08 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-Id: <20050411105008.71b3422a.pj@engr.sgi.com>
In-Reply-To: <20050411151204.GA5562@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	<20050411113523.GA19256@elte.hu>
	<20050411074552.4e2e656b.pj@engr.sgi.com>
	<20050411151204.GA5562@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> actually, git would just include by reference the previous blob.

Ok - kind of like a patch blob.  I can see now where under some
conditions this saves space.

I agree with conclusion this thread has already reached.  Keep it
simple.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
