Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSLCRyj>; Tue, 3 Dec 2002 12:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSLCRyj>; Tue, 3 Dec 2002 12:54:39 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:17088
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S262813AbSLCRyi>; Tue, 3 Dec 2002 12:54:38 -0500
Message-ID: <3DECF34A.3000407@tupshin.com>
Date: Tue, 03 Dec 2002 10:09:14 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de>
In-Reply-To: <20021203121521.GB30431@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bugzillla Dave Jones wrote:

>whilst on the subject of bugzilla:
>a few people (myself included) go through the bug database once a week
>or so pruning out-of-date/fixed entries. So far the ones I've closed have
>been quite sensible, but there are a few there of the form..
>
>"xxx doesn't work in 2.5.47", then Rusty's module rewrite happened,
>and the tester didn't (or couldn't) see if it got fixed in subsequent
>kernels. I'll send out pings to such reports when they get to something
>like 5 kernels old. If the problem then doesn't get re-ACKed, I'll
>close it. Any objections?
>
>		Dave
>
Thankfully osdl has been set up with very useful fields for such things. 
It sounds like cases that you are describing should be rejected with a 
status of either "UNREPRODUCIBLE" if the bug report was decently done, 
but you can't reproduce it, or "INSUFFICIENT_DATA" if the bug report was 
filed inadequately. This can serve as a prompt to the original filer to 
re-open it with better data.

I don't think you should hesitate to do that at least once for a bug 
fits either of those cases.

-Tupshin


