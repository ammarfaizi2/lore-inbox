Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbTACLEd>; Fri, 3 Jan 2003 06:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbTACLEd>; Fri, 3 Jan 2003 06:04:33 -0500
Received: from holomorphy.com ([66.224.33.161]:11977 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267493AbTACLEd>;
	Fri, 3 Jan 2003 06:04:33 -0500
Date: Fri, 3 Jan 2003 03:12:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd phenomenon.
Message-ID: <20030103111253.GE9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030103103816.GA2567@codemonkey.org.uk> <20030103104809.GD9704@holomorphy.com> <20030103110901.GC2567@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103110901.GC2567@codemonkey.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Dave Jones wrote:
>>> It's almost 100% reproducable here.  Only seen it do it on this box
>>> though which is a P4 with HT, so it could be SMP related..
>>> Ideas ?

On Fri, Jan 03, 2003 at 02:48:09AM -0800, William Lee Irwin III wrote:
>> (1) strace?

On Fri, Jan 03, 2003 at 11:09:01AM +0000, Dave Jones wrote:
> That was my first thought. Everything works as expected though
> when you try to strace it.

Highly unusual. In-kernel tracing seems to be in order. Can you
describe a more complete "reproduction suite" (esp. app/lib versions)?


Thanks,
Bill
