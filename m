Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbTLaD1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 22:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266100AbTLaD1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 22:27:21 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:34497 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266099AbTLaD1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 22:27:20 -0500
Date: Tue, 30 Dec 2003 19:27:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: john moser <bluefoxicy@linux.net>, linux-kernel@vger.kernel.org
Subject: Re: Slab allocator . . . cache?  WTF is it?
Message-ID: <20031231032716.GZ1882@matchmail.com>
Mail-Followup-To: john moser <bluefoxicy@linux.net>,
	linux-kernel@vger.kernel.org
References: <20031230221859.15F503956@sitemail.everyone.net> <20031230235029.GY1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230235029.GY1882@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 03:50:29PM -0800, Mike Fedyk wrote:
> First of all, does it swap out and stay swapped out, or does it swap in and
> out constantly?

http://www.matchmail.com/stats/lrrd/matchmail.com/fileserver.matchmail.com-swap.html

Look at the monthly graph.

Weeks 49 and 50 are 2.4.20-rmap.

Week 51 to half of week 52 is 2.4.23

After that it is 2.4.23-aa1.

I'd suggest that if you have any problems with too much swapping in and out,
to try 2.4.23-aa1.

Mike

