Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTFJS3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTFJS3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:29:22 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:42389 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261919AbTFJS3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:29:20 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 10 Jun 2003 11:41:00 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards. (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
In-Reply-To: <03061013171201.06462@tabby>
Message-ID: <Pine.LNX.4.55.0306101139470.4859@bigblue.dev.mcafeelabs.com>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk>
 <3EE4D80A.2050402@techsource.com> <Pine.LNX.4.55.0306091142420.3614@bigblue.dev.mcafeelabs.com>
 <03061013171201.06462@tabby>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, Jesse Pollard wrote:

> On Monday 09 June 2003 13:58, Davide Libenzi wrote:
> [snip]
> >
> > If you try to define a bad/horrible "whatever" in an *absolute* way you
> > need either the *absolutely* unanimous consent or you need to prove it
> > using a logical combination of already proven absolute concepts. Since you
> > missing both of these requirements you cannot say that something is
> > bad/wrong in an absolute way. You can say though that something is
> > wrong/bad when dropped inside a given context, and a coding standard might
> > work as an example. If you try to approach a developer by saying that he
> > has to use ABC coding standard because it is better that his XYZ coding
> > standard you're just wrong and you'll have hard time to have him to
> > understand why he has to use the suggested standard when coding inside the
> > project JKL. The coding standard gives you the *rule* to define something
> > wrong when seen inside a given context, since your personal judgement does
> > not really matter here.
>
> The coding standards were written by people who said
>
> "Do it this way because 'I' have to read it and understand it to be able to
> maintain it."

The whole sub-thread wasn't talking about democracy in coding styles ;)



- Davide

