Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272412AbTHEDUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272413AbTHEDUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:20:05 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:57216 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S272412AbTHEDT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:19:59 -0400
Date: Tue, 5 Aug 2003 11:19:56 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Eugene Teo <eugene.teo@eugeneteo.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Memory-related problem leads to laptop freeze
Message-ID: <20030805031956.GA6112@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <20030803091115.GA781@eugeneteo.net> <20030804100322.1c7a9795.rddunlap@osdl.org> <20030805023108.GB5562@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805023108.GB5562@eugeneteo.net>
X-Operating-System: Linux 2.4.21-ck3
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Eugene Teo">
> <quote sender="Randy.Dunlap">
> > On Sun, 3 Aug 2003 17:11:15 +0800 Eugene Teo <eugene.teo@eugeneteo.net> wrote:
> > 
> > | Hi everyone,
> > | 
> > | I was using kernel 2.6.0-test2-mm3. As usual, I anticipated that
> > | I will have a random freeze, and true enough, I have one after a
> > | few hours.
> > | 
> > | I have attached the log. Please take a look, and advise.
> > 
> > Hi,
> > 
> > What were you doing?  It seems that you have had several (repeated?)
> > problems.  Were you doing the same kind of activity each time,
> > or are they "random," as you say?
> 
> It is random. Even when I am not doing nothing, I get hangs. If I am
> doing something, then it probably is icqing, ircing, compiling kernel,
> editing codes, mutt'ing, that's all. I did not try to test the kernel
> real hard.

I know this is not useful info but I hope I am not the
only one experiencing this problem. If anyone can get
hold of the Fujitsu E-7010 laptop, you should be able
to reproduce this results. Let me know if you want my
.config. I have tested my ram using memtest86, no errors
at all. I have yet test a minimal kernel configuration 
as suggested by Andrew but will do so later on but I am
sure it will be a painful one, even with ccache :/

Eugene

