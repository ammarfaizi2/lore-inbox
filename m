Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWCEXNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWCEXNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWCEXNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:13:34 -0500
Received: from kanga.kvack.org ([66.96.29.28]:58275 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751916AbWCEXNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:13:34 -0500
Date: Sun, 5 Mar 2006 18:08:21 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: jonathan@jonmasters.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] inotify hack for locate
Message-ID: <20060305230821.GA20768@kvack.org>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> <1141594983.14714.121.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141594983.14714.121.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 04:43:03PM -0500, Lee Revell wrote:
> updatedb runs at nice 20 on most distros, and with the CFQ scheduler the
> IO priority follows the nice value, so why does it still kill the
> machine?

Running updatedb on a laptop when you're sitting in an airplane running 
off of batteries is Not Nice to the user.  I know, I've had it happen far 
too many times.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
