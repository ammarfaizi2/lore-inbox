Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275309AbTHSCe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 22:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275310AbTHSCe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 22:34:27 -0400
Received: from holomorphy.com ([66.224.33.161]:13802 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S275309AbTHSCe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 22:34:26 -0400
Date: Mon, 18 Aug 2003 19:35:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
Message-ID: <20030819023536.GZ32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F4182FD.3040900@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4182FD.3040900@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 11:53:01AM +1000, Nick Piggin wrote:
> As per the latest trend these days, I've done some tinkering with
> the cpu scheduler. I have gone in the opposite direction of most
> of the recent stuff and come out with something that can be nearly
> as good interactivity wise (for me).
> I haven't run many tests on it - my mind blanked when I tried to
> remember the scores of scheduler "exploits" thrown around. So if
> anyone would like to suggest some, or better still, run some,
> please do so. And be nice, this isn't my type of scheduler :P
> It still does have a few things that need fixing but I thought
> I'd get my first hack a bit of exercise.
> Its against 2.6.0-test3-mm1

Say, any chance you could spray out a brief explanation of your new
heuristics?


-- wli
