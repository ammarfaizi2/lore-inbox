Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbTFMQJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbTFMQJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:09:04 -0400
Received: from forty.greenhydrant.com ([208.48.139.185]:24518 "EHLO
	forty.greenhydrant.com") by vger.kernel.org with ESMTP
	id S265141AbTFMQJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:09:01 -0400
Message-ID: <3570.66.75.244.69.1055521381.squirrel@www.greenhydrant.com>
Date: Fri, 13 Jun 2003 09:23:01 -0700 (PDT)
Subject: Re: 3ware and two drive hardware raid1
From: "David Rees" <dbr@greenhydrant.com>
To: <mdresser_l@windsormachine.com>
In-Reply-To: <Pine.LNX.4.33.0306131017010.16766-100000@router.windsormachine.com>
References: <1055494998.5162.26.camel@dhcp22.swansea.linux.org.uk>
        <Pine.LNX.4.33.0306131017010.16766-100000@router.windsormachine.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser said:
>
> I'm heading out there today to take a look at the machine and see what
> happened.  I'm rather dissappointed in the 3ware utility, it alternately
> claims both drives are ok(./tw_cli info c1 is different from ./tw_cli
> info c1 u0)
>
> I was relying on that too much, and ignored the possiblity of two drive
> failure.  Looks like both drives would have failed at exactly the same
> time, which sounds like a power spike.

On the 3ware boxes I use, I setup the 3DM utility to run weekly scans of
the unit to look for badblocks, do you do the same thing?  I've had the
scan turn up bad disks before.

-Dave


