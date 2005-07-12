Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVGLJOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVGLJOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVGLJMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:12:48 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:16033
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261278AbVGLJMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:12:25 -0400
Message-ID: <42D3896B.4070806@ev-en.org>
Date: Tue, 12 Jul 2005 10:12:11 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com,
       rostedt@goodmis.org, prasadav@us.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com>	<20050711184558.6346e77c.akpm@osdl.org> <17107.10600.661157.164699@tut.ibm.com>
In-Reply-To: <17107.10600.661157.164699@tut.ibm.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi wrote:
> Andrew Morton writes:
>  > Tom Zanussi <zanussi@us.ibm.com> wrote:
>  > >
>  > > Hi Andrew, can you please merge relayfs?
>  > 
>  > I guess so.  Would you have time to prepare a list of existing and planned
>  > applications?
> 
> I've also added a couple of people to the cc: list that I've consulted
> with in getting their applications to use relayfs, one of which is the
> logdev debugging device recently posted to LKML.

I'm using relayfs during my development work to log the current TCP
stack parameters and timing information. There is no reason that I can
see to merge this into the kernel, but it's very useful for my
development work.

I'd like to see relayfs merged.

Baruch
