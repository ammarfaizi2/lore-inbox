Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTJ0MhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTJ0MhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:37:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42506 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261656AbTJ0MhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:37:01 -0500
Date: Mon, 27 Oct 2003 12:36:49 +0000
From: Dave Jones <davej@redhat.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Burton Windle <bwindle@fint.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: fsstress causes memory leak in test6, test8
Message-ID: <20031027123649.GB27611@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.58.0310251842570.371@morpheus> <20031026170241.628069e3.akpm@osdl.org> <20031027121609.GA27611@redhat.com> <3F9D1014.5000006@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9D1014.5000006@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 03:31:16PM +0300, Hans Reiser wrote:
 > >This could explain the random reiserfs oopses/hangs I was seeing several
 > >months back after running fsstress for a day or so. The reiser folks
 > >were scratching their heads, and we even put it down to flaky hardware
 > >or maybe even a CPU bug back then.
 > > 
 > This means we failed to make a properly serious effort at replicating it 
 > on our hardware.  My apologies for that.

It happens.

 > Who at Namessys was it that 
 > investigated your bug report?

Can't remember, it's in the archives somewhere.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
