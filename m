Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAHXpu>; Mon, 8 Jan 2001 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAHXpl>; Mon, 8 Jan 2001 18:45:41 -0500
Received: from cs16028-106.austin.rr.com ([24.160.28.106]:44417 "EHLO
	confucius.gnacademy.org") by vger.kernel.org with ESMTP
	id <S129226AbRAHXpd>; Mon, 8 Jan 2001 18:45:33 -0500
Date: Mon, 8 Jan 2001 17:35:10 -0600 (CST)
From: Joseph Wang <joe@gnacademy.tzo.org>
To: <linux-kernel@vger.kernel.org>
Subject: HomePNA 2.0 flamage
Message-ID: <Pine.LNX.4.30.0101081724340.10568-100000@confucius.gnacademy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to search for a 10 Mpbs phone ethernet card that works
with linux.  Apparently all of the products that implement HomePNA 2.0
use the Broadcom chipset and Broadcom has been extremely non-responsive
at providing chipset specifications.

The situation really irks me because the whole point of having a standard
is to allow for competition between different manufacturers.  In the
case of HomePNA 1.0, there were some chipsets that provided enough
information to write a driver and it was possible to use market pressure
to force chipset makers to make their products usable with linux.
There were about four or five chip manufacturers with homePNA 1.0 chips
and some of them provided some excellent documentation and tech specs.

This doesn't seem to be the case with HomePNA 2.0 which makes me suspect
that Broadcom has a patent on some critical piece of technology.  I
can't think of any other reason how they seem to have a defacto monopoly
on HomePNA 2.0 products.  This is bad because HomePNA 1.0 products
are becoming increasingly difficult to find.

My question is

1) do I have any options other than to give up on HomePNA 2.0 and start
digging holes in walls.  At this point, I would welecome any product
that doesn't use a broadcom chip set.

2) how did Broadcom manage to get a de-facto monopoly on high speed
phone line ethernet cards?  If it's possible for Broadcom to do this
with phone line ethernet, I shudder to think about the possibility of
some other linux-unfriendly company owning a piece of critical technology.

3) is there anything that we as a community can do other than to keep
shouting at broadcom?A

-- 
-------------------------------------------------------------------------------
Joseph Wang Ph.D.          Globewide Network Academy
president@gnacademy.org    FREE Distance Education catalog database
http://www.gnacademy.org   Over 20,000 courses and degrees

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
