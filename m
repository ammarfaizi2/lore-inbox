Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVEJTTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVEJTTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVEJTSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:18:02 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16031 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261750AbVEJTRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:17:21 -0400
Message-ID: <4280E354.9070705@tmr.com>
Date: Tue, 10 May 2005 12:37:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Andrew Morton <akpm@osdl.org>, jfbeam@bluetronic.net,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org> <20050510002121.7076feb6.pj@sgi.com> <20050510143838.GG2297@csclub.uwaterloo.ca>
In-Reply-To: <20050510143838.GG2297@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Tue, May 10, 2005 at 12:21:21AM -0700, Paul Jackson wrote:
> 
>>Yes - it's all there.  Sometimes the ways to discover it aren't pretty,
>>but that's one thing that libraries are good for - to wrap such detail.
> 
> 
> And then when the kernel adds something new, you update one library
> rather than 1000s of applications.
> 
> Perhaps making it hard to get at without a certainl library is a good
> way to avoid too many applications poling at it just because they can.

The advantage of /proc is that it works from C, Java, Perl, Python, etc. 
Oh, and humans, the reason all the application run.

