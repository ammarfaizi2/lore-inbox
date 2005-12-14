Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVLNRWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVLNRWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVLNRWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:22:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18617 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751300AbVLNRWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:22:09 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Brian Gerst" <bgerst@didntduck.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "M." <vo.sinh@gmail.com>,
       "Andrea Arcangeli" <andrea@suse.de>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<20051205121851.GC2838@holomorphy.com>
	<20051206011844.GO28539@opteron.random>
	<43944F42.2070207@didntduck.org> <20051206030828.GA823@opteron.random>
	<f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>
	<1133869465.4836.11.camel@laptopd505.fenrus.org>
	<4394ECA7.80808@didntduck.org>
	<Pine.LNX.4.61.0512060855050.12611@chaos.analogic.com>
	<m1acf3aba2.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0512141200520.13496@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 14 Dec 2005 10:20:19 -0700
In-Reply-To: <Pine.LNX.4.61.0512141200520.13496@chaos.analogic.com> (linux-os@analogic.com's
 message of "Wed, 14 Dec 2005 12:01:49 -0500")
Message-ID: <m11x0fa94c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Wed, 14 Dec 2005, Eric W. Biederman wrote:
>
>> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
>>
>>> When the linux-BIOS group started, few knew where to start. Then,
>>> mysteriously, there was a complete directory tree of a well-known
>>> BIOS that appeared on the web. That was a start.
>>
>> Nope it wasn't.  None of the developers even read the code.
>> We needed to keep our hands clean.
>>
>> Eric
>>
>
> Standard disclaimer #123

And it is true.

It's not like a mess of 20 year old spaghetti assembly is a useful
starting point for anything.

I sat down and I read the relevant standards documents and what
chipset documentation there was and I manged to write code.

It's not like there is anything fundamentally hard about what bootstrap
firmware does.

Not to be insulting but disbelief here sounds a lot like SCO's assertion
that Linus couldn't written linux.

Eric
