Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTAJOMg>; Fri, 10 Jan 2003 09:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbTAJOMg>; Fri, 10 Jan 2003 09:12:36 -0500
Received: from angband.namesys.com ([212.16.7.85]:59076 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265008AbTAJOMf>; Fri, 10 Jan 2003 09:12:35 -0500
Date: Fri, 10 Jan 2003 17:21:15 +0300
From: Oleg Drokin <green@namesys.com>
To: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Severe reiserfs problems
Message-ID: <20030110172115.A9028@namesys.com>
References: <200301101332.50873.robert.szentmihalyi@entracom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200301101332.50873.robert.szentmihalyi@entracom.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jan 10, 2003 at 01:32:50PM +0100, Robert Szentmihalyi wrote:
> I have severe file system problems on a reiserfs partition.
> When I try copy files to another filesystem, the kernel panics at certain 
> files.

Can you tell us what the panics were?
What was the kernel version?

> reiserfsck --fix-fixable says that I need to run 
> reiserfsck --rebuild-tree to fix the errors, but when I do this,
> reiserfsck hangs after a few secounds.

What's the reiserfsck version you have?
What do you mean by hangs? Does it eats cpu time or something?

> Is there a way to rescue at least some of the data on the partition?

There is not enough info yet to know the answer.

Bye,
    Oleg
