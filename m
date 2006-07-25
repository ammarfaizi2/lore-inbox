Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWGYU1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWGYU1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWGYU1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:27:02 -0400
Received: from hera.kernel.org ([140.211.167.34]:64910 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751549AbWGYU1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:27:00 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: async network I/O, event channels, etc
Date: Tue, 25 Jul 2006 13:25:54 -0700
Organization: OSDL
Message-ID: <20060725132554.38773695@localhost.localdomain>
References: <44C66FC9.3050402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1153859155 26035 10.8.0.54 (25 Jul 2006 20:25:55 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 25 Jul 2006 20:25:55 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 12:23:53 -0700
Ulrich Drepper <drepper@redhat.com> wrote:

> I was very much surprised by the reactions I got after my OLS talk.
> Lots of people declared interest and even agreed with the approach and
> asked me to do further ahead with all this.  For those who missed it,
> the paper and the slides are available on my home page:
> 
> http://people.redhat.com/drepper/
> 
> 
> As for the next steps I see a number of possible ways.  The discussions
> can be held on the usual mailing lists (i.e., lkml and netdev) but due
> to the raw nature of the current proposal I would imagine that would be
> mainly perceived as noise.
> 
> So the second proposal is the I can create an appropriate mailing list
> here.  Alternatively possibly two lists, one for the event channel stuff
> and one for the DMA/AIO part since the two parts are very much unrelated.
> 
> I'd appreciate input from those who feel responsible for these lists.  I
> don't mind either way.  If there is strong interest right now (let me
> know, don't pollute the list) I can create mailing lists now and then if
> necessary close them down and redirect traffic to lkml/netdev.
> 
> Waiting for input...
> 

I would prefer directing the API discussion to netdev@vger.kernel.org
