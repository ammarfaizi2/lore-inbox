Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135353AbRDZMJg>; Thu, 26 Apr 2001 08:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135346AbRDZMJ0>; Thu, 26 Apr 2001 08:09:26 -0400
Received: from corp2.cbn.net.id ([202.158.3.25]:23304 "HELO corp2.cbn.net.id")
	by vger.kernel.org with SMTP id <S135344AbRDZMJT>;
	Thu, 26 Apr 2001 08:09:19 -0400
Date: Thu, 26 Apr 2001 19:11:24 +0700 (JAVT)
From: <imel96@trustix.co.id>
To: John Cavan <johnc@damncats.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
In-Reply-To: <3AE741EA.561BE01F@damncats.org>
Message-ID: <Pine.LNX.4.33.0104261836130.1677-100000@tessy.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Apr 2001, John Cavan wrote:

> Several distributions (Red Hat and Mandrake certainly) offer auto-login
> tools. In conjunction with those tools, take the approach that Apple
> used with OS X and setup "sudo" for administrative tasks on the machine.
> This allows the end user to generally administer the machine without all
> the need to hack the kernel, modify login, operate as root, etc. You can
> even restrict their actions with it and log what they do.
>
> In the end though, I really don't see the big deal with having a root
> user for general home use. Even traditionally stand-alone operating
>

you're right, we could do it in more than one way. like copying
with mcopy without mounting a fat disk. the question is where to put it.
why we do it is an important thing.
taking place as a clueless user, i think i should be able to do anything.
i'd be happy to accept proof that multi-user is a solution for
clueless user, not because it's proven on servers. but because it is
a solution by definition.



		imel


