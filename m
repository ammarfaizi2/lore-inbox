Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTFJSD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFJSD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:03:57 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:751 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262488AbTFJSDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:03:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Davide Libenzi <davidel@xmailserver.org>,
       Timothy Miller <miller@techsource.com>
Subject: Re: Coding standards. (Was: Re: [PATCH] [2.5] Non-blocking write can block)
Date: Tue, 10 Jun 2003 13:17:12 -0500
X-Mailer: KMail [version 1.2]
Cc: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <3EE4D80A.2050402@techsource.com> <Pine.LNX.4.55.0306091142420.3614@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0306091142420.3614@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Message-Id: <03061013171201.06462@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 June 2003 13:58, Davide Libenzi wrote:
[snip]
>
> If you try to define a bad/horrible "whatever" in an *absolute* way you
> need either the *absolutely* unanimous consent or you need to prove it
> using a logical combination of already proven absolute concepts. Since you
> missing both of these requirements you cannot say that something is
> bad/wrong in an absolute way. You can say though that something is
> wrong/bad when dropped inside a given context, and a coding standard might
> work as an example. If you try to approach a developer by saying that he
> has to use ABC coding standard because it is better that his XYZ coding
> standard you're just wrong and you'll have hard time to have him to
> understand why he has to use the suggested standard when coding inside the
> project JKL. The coding standard gives you the *rule* to define something
> wrong when seen inside a given context, since your personal judgement does
> not really matter here.

The coding standards were written by people who said

"Do it this way because 'I' have to read it and understand it to be able to 
maintain it."

Nuff said.
