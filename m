Return-Path: <linux-kernel-owner+w=401wt.eu-S965035AbWL2I4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWL2I4j (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 03:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWL2I4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 03:56:38 -0500
Received: from javad.com ([216.122.176.236]:1609 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965035AbWL2I4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 03:56:37 -0500
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
	<552766292581216610@wsc.cz> <554564654653216610@wsc.cz>
	<87d564x7r0.fsf@javad.com> <459453E6.6020104@gmail.com>
Date: Fri, 29 Dec 2006 11:56:23 +0300
In-Reply-To: <459453E6.6020104@gmail.com> (Jiri Slaby's message of "Fri, 29
	Dec 2006 00:31:27 +0059")
Message-ID: <87zm97krm0.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

[...]

>> # rmmod mxser_new
>> Trying to free already-free IRQ 58
>> Trying to free nonexistent resource <0000000000009000-000000000000903f>
>> Trying to free nonexistent resource <0000000000008800-0000000000008800>
>
> Thanks, I'll fix this and let you know. Does this happed every time you try to
> unload it?

Yes, it's stable. Happens every time.

-- Sergei.

