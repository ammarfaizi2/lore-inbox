Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270754AbTGUVTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270753AbTGUVTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:19:20 -0400
Received: from holomorphy.com ([66.224.33.161]:50842 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270741AbTGUVS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:18:28 -0400
Date: Mon, 21 Jul 2003 14:34:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-wli-1 compile fail
Message-ID: <20030721213428.GU15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307211717270.23650-101000@oddball.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307211717270.23650-101000@oddball.prodigy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 05:19:30PM -0400, root wrote:
> Error:
> fs/namei.c: In function `path_lookup':
> fs/namei.c:868: parse error before `*'
> fs/namei.c:873: `dirs' undeclared (first use in this function)
> fs/namei.c:873: (Each undeclared identifier is reported only once
> fs/namei.c:873: for each function it appears in.)
> fs/namei.c:873: `fs' undeclared (first use in this function)
> fs/namei.c:890: `task' undeclared (first use in this function)
> make[1]: *** [fs/namei.o] Error 1
> make: *** [fs] Error 2
> gzipped and comment-stripped config attached. And I had such hopes...

That's moderately unusual. I didn't announce this; it was intended to
be a drop for various odd testers, not generally released.

Try 1A, ISTR having compiled that.


-- wli
