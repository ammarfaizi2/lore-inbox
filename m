Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131544AbRBDO4F>; Sun, 4 Feb 2001 09:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131803AbRBDOz4>; Sun, 4 Feb 2001 09:55:56 -0500
Received: from james.kalifornia.com ([208.179.0.2]:19547 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131544AbRBDOzv>; Sun, 4 Feb 2001 09:55:51 -0500
Message-ID: <3A7D6C66.749318E1@kalifornia.com>
Date: Sun, 04 Feb 2001 06:51:18 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: James Sutherland <jas88@cam.ac.uk>, Russell King <rmk@arm.linux.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Pavel Machek <pavel@suse.cz>, andrew.grover@intel.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Better battery info/status files
In-Reply-To: <Pine.LNX.4.30.0102041354060.17227-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> On Sun, 4 Feb 2001, James Sutherland wrote:
>
> > For the end-user, the ability to see readings in other units would be
> > useful - how many people on this list work in litres/metres/kilometres,
> > and how many in gallons/feet/miles? Probably enough in both groups that
> > neither could count as universal...
>
> Yeah. We can have this as part of the locale settings, changable by
> echoing the desired locale string to /proc/sys/kernel/lc_all.
>
> -

Just an idea, . .  but isn't this something better done in userland?

(ben@Deacon)-(06:49am Sun Feb  4)-(ben)
$ date  +%s
981298161
(ben@Deacon)-(06:49am Sun Feb  4)-(ben)
$ date  +%c
Sun Feb  4 06:49:24 2001


-b

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
