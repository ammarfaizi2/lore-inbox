Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbVI3BZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbVI3BZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVI3BZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:25:25 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:7557 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751403AbVI3BZX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:25:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gjBTW50LcA6DgnmEzN2Uz7VxoaThe3RzxnVDM/KI9NJVh8jZu2HTVS+Xh+cWlo4aV7mP68B/sIbfSpc+QksC35ljE89eIZN9W48fUtw+a+nbvUddX/3OBXwi9q/fxQg8UPnipyjRC7vIfJ5LPZjguLDkBl7iPaPZSNXXgjHUVdk=
Message-ID: <924c28830509291825y10c1709bt9a648ef3fb89b22@mail.gmail.com>
Date: Thu, 29 Sep 2005 18:25:22 -0700
From: Hua Zhong <hzhong@gmail.com>
Reply-To: Hua Zhong <hzhong@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Cc: Luben Tuikov <ltuikov@yahoo.com>, Arjan van de Ven <arjan@infradead.org>,
       Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once there are known holes in the theory, it's not a
> scientific theory. At best it's an approximation, but
> quite possibly it's just plain wrong.

You are right about scientific theory, but specs are not just a theory.
You are mixing "discovery" and "invention".

A scientific theory has to match reality, because the universe deveops
independently. There is no way you can enforce your theory down the
throat on the "nature".

But the roles of specs are more than that. There are two parts of it:
1. unify/summarize the reality
2. guide future implementations on a unified road

It might do job 1 poorly (simply because the reality is a mess),
but if everyone from the point on puts the effort to follow it, job 2 can
be done, and it is the real goal. It can do this simply because *humans*
can collaborate and be influenced for a goal that could eventually
benefit everybody.

> And that's my point. Specs are not only almost invariably
> badly written, they also never actually match reality.
>
> At which point at _best_ it's just an approximation. At
> worst, it's much worse. At worst, it causes people to
> ignore reality, and then it becomes religion.

Let me add more to the moron/asshole argument:

Anyone that thinks specs are reality is a moron.

Anyone that thinks specs are useless and refuses to collaborate
is an asshole. :)
