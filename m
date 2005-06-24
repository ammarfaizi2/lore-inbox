Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbVFXKct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbVFXKct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbVFXKct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:32:49 -0400
Received: from [80.71.243.242] ([80.71.243.242]:38534 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S263167AbVFXKbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:31:07 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>,
       "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       Markus =?ISO-8859-1?Q?=20=22T=16rnqvist=22?= <mjt@nysv.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>
	<42B9DD48.6060601@slaphack.com>
	<17081.58619.671650.812286@gargle.gargle.HOWL>
	<42BAC668.2030604@slaphack.com>
	<17083.14428.546772.353003@gargle.gargle.HOWL>
	<42BBAA0F.2020404@namesys.com>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Fri, 24 Jun 2005 14:31:07 +0400
In-Reply-To: <42BBAA0F.2020404@namesys.com> (Hans Reiser's message of "Thu,
 23 Jun 2005 23:37:03 -0700")
Message-ID: <m1slz8oxlg.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> Nikita, I respectfully disagree with what you say about the state of our
> atomicity code.   It is not so far away as you describe, and probably 6
> man weeks work could polish it off.  You don't see the value in what I
> define as useful, namely atomicity without isolation.  Since you don't
> see that, it is harder for you to see that something is close to working
> and just needs 6 weeks of someone who groks what I am asking for.

No, I see the value of "atomicity", and think it is very useful. What I
don't see the value of is the making of premature claims.

_When_ reiser4 has atomic write(2), you have full right to call it
atomic, not before.

_When_ reiser4 is tested through objective benchmark-set exercising
various workloads, you can refer to these benchmarks as the proof of
reiser4 technical superiority, not before.

On a more personal note, I invested large amount of my time and effort
into developing reiser4, and I feel attached to it and to the great
ideas embodied in it. For reiser4 to rot on the forgotten shelf in
obscurity is the thing I want least. I want it to be included into
mainline kernel, but for this to happen, you have to take more realistic
stance towards err... reality.

>
> Hans

Nikita.
