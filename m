Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTJGCz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 22:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTJGCz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 22:55:29 -0400
Received: from mail.midmaine.com ([66.252.32.202]:3281 "HELO mail.midmaine.com")
	by vger.kernel.org with SMTP id S261779AbTJGCz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 22:55:28 -0400
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: ide problem in newer kernel or disc failure
X-Eric-Conspiracy: There Is No Conspiracy
References: <1064881613.811.8.camel@simulacron>
	<200309301357.15548.bzolnier@elka.pw.edu.pl>
	<1064926083.2511.4.camel@simulacron>
From: Erik Bourget <erik@midmaine.com>
Date: Mon, 06 Oct 2003 22:54:20 -0400
In-Reply-To: <1064926083.2511.4.camel@simulacron> (Andreas Jellinghaus's
 message of "Tue, 30 Sep 2003 14:48:04 +0200")
Message-ID: <87fzi5vjtv.fsf@loki.odinnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus <aj@dungeon.inka.de> writes:

> On Di, 2003-09-30 at 13:57, Bartlomiej Zolnierkiewicz wrote:
>> On Tuesday 30 of September 2003 02:26, Andreas Jellinghaus wrote:
>> > Hi,
>> >
>> > my disc starts showing problems. a few weeks ago it was fine.
>> > could that be a problem with latest 2.6.0-test* kernels
>> > or is my disc failing?
>> 
>> <...>
>> 
>> Looks like a failing disk (errors logged by SMART).
>
> thanks. however I wonder: smart extended test does not
> find any error, and this morning the disc was fine again.
>
> the machine was turned off, and it's a laptop. so could this
> be related to temperature or something like that? 
>
> Regards, Andreas

Andreas -

I am beginning to think that the entire line of Hitachi deskstar drives are
faulty.  I just returned THIRTY of them.  The Western Digital drives do not
share the Hitachi tendency for failing after 300 hours of constant heavy use.

- Erik

