Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270458AbTGXELh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 00:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270473AbTGXELg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 00:11:36 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:23227
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S270458AbTGXELg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 00:11:36 -0400
Message-ID: <3F1F6005.4060307@tupshin.com>
Date: Wed, 23 Jul 2003 21:26:45 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: linux-kernel@vger.kernel.org,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com>
In-Reply-To: <3F1EF7DB.2010805@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Please look at http://www.namesys.com/benchmarks/v4marks.html
>
> In brief, V4 is way faster than V3, and the wandering logs are indeed 
> twice as fast as fixed location logs when performing writes in large 
> batches.
>
<snip>
I am interested in testing this out, but the latest patch on the namesys 
sight appears to be against 2.5.60 which was never usable on my 
hardware. If there is a later patch, or if somebody has adapted it to 
work against 2.6.0-test1(or anything comparably recent), please let me know.

-Tupshin

