Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVJ0P0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVJ0P0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVJ0P0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:26:43 -0400
Received: from xenotime.net ([66.160.160.81]:30187 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751079AbVJ0P0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:26:43 -0400
Date: Thu, 27 Oct 2005 08:26:40 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: jonathan@jonmasters.org
cc: Paul Albrecht <palbrecht@qwest.net>, linux-kernel@vger.kernel.org
Subject: Re: yet another c language cross-reference for linux
In-Reply-To: <35fb2e590510270822q39db180fh530ce80bb9ec57ba@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0510270825270.16977@shark.he.net>
References: <000501c5daf1$bbd37c60$e8c90443@oemcomputer>
 <35fb2e590510270822q39db180fh530ce80bb9ec57ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005, Jon Masters wrote:

> On 10/27/05, Paul Albrecht <palbrecht@qwest.net> wrote:
>
> > I have written another cross-referencing tool for the c language because I
> > have been dissatisfied with existing tools such as ctags and lxr.
>
> Ok.
>
> > I'd like to get some feedback to determine whether other programmers
> > find the program useful
>
> It seems to be in its very early stages now. I can barely navigate the
> 2.4.31 source and it doesn't offer anything like the functionality of
> lxr. But if you want to, perhaps it's worthwhile developing it further
> and releasing it.

Maybe this is a meta-comment, but I would find it useful
if xvr script (source) files contained (used) some indentation.
I don't see any.

> Your README file suggests that LXR fails because it requires a
> webserver. Personally, I've never seen that to be an issue and find it
> very very useful indeed (although it has limitations and doesn't
> always index every symbol I would want to lookup), especially with
> coywolf keeping an up-to-date lxr for 2.6. Mel Gorman used it for his
> ULVMM book and I'm sure others are using LXR extensively - so it might
> be worth extending that.
>
> I'd love it if vendors would actually index their kernels with LXR.

-- 
~Randy
