Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTLKQwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbTLKQwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:52:08 -0500
Received: from monsoon.he.net ([64.62.221.2]:59285 "HELO monsoon.he.net")
	by vger.kernel.org with SMTP id S265181AbTLKQwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:52:04 -0500
Date: Thu, 11 Dec 2003 08:51:58 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, "" <maneesh@in.ibm.com>,
       "" <mgorse@mgorse.dhs.org>, "" <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: oopses in kobjects in 2.6.0-test11 (was Re: kobject patch)
In-Reply-To: <20031208225840.GA31245@kroah.com>
Message-ID: <Pine.LNX.4.50.0312110849040.14967-100000@monsoon.he.net>
References: <20031009014837.4ff71634.akpm@osdl.org> <20031208222526.GA31134@kroah.com>
 <20031208224810.GB31134@kroah.com> <20031208225840.GA31245@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about the delay in getting back to you.

> Here's a patch for kobject.c that should fix this problem and keep
> kobject parent's around until after the child is gone.  Please can
> someone verify that I didn't get this wrong...

The patch looks good, please forward it on to Linus/Andrew.

Thanks,


	Pat

P.S. I've left OSDL to go work for a startup. Please use this email
address from now on.
