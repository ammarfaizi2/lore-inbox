Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbUCZGEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 01:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbUCZGEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 01:04:10 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:14576 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263688AbUCZGEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 01:04:07 -0500
Date: Fri, 26 Mar 2004 13:59:47 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@suse.cz>,
       "Nigel Cunningham" <ncunningham@users.sourceforge.net>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Cc: "Suspend development list" <swsusp-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net> <1080247142.6679.3.camel@calvin.wpcb.org.au> <20040325222745.GE2179@elf.ucw.cz> <1080250718.6674.35.camel@calvin.wpcb.org.au> <20040325225453.GH2179@elf.ucw.cz>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5gf9xbh4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040325225453.GH2179@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 23:54:53 +0100, Pavel Machek <pavel@suse.cz> wrote:

> Hi!
>
>> > only "non compressed" part to reach mainline for 2.6. Feature freeze
>> > was few months ago, and "adding possibility to compress swsusp data"
>> > does not sound like a bugfix to me...
>>
>> Feature freeze is always half unfrozen anyway. 2.4 just gained XFS!
>> I'm
>
> XFS probably has 10+ people working on it, full time, and it still
> required quite a lot of pushing.

We could push harder. Should we ask all swsusp2 users using
compression to announce themselves on LKML? ;)

Michael
