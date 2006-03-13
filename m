Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWCMA5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWCMA5u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 19:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWCMA5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 19:57:49 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:9085 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932308AbWCMA5t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 19:57:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F7+Ucp6C+2ZOFpyvG2qmWWqTLwSMMBviruagRL6Kkf1SCkwdVrVNCsmOPpo/U1xehBj033PeZ3jFerqCdU7Ah5UCHLRs21C2dlwgfsVWnxIEKfIMBWnUcJVSobC9bUmq3oF/ypCdGOrCjvpFe8pDkLQJSS+dFCSFKen8rIRGBmQ=
Message-ID: <5a4c581d0603121657w768a7e3x765d77b7fcc8b954@mail.gmail.com>
Date: Mon, 13 Mar 2006 01:57:48 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: gbakos@cfa.harvard.edu
Subject: Re: 2.6.15 -- unable to open an initial console
Cc: "Jiri Slaby" <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.58.0603121842110.22310@cfassp0.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1FIZ9B-00089K-00@decibel.fi.muni.cz>
	 <Pine.SOL.4.58.0603121842110.22310@cfassp0.cfa.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Gaspar Bakos <gbakos@cfa.harvard.edu> wrote:
> Hi, Jiri,
>
> RE:
> > have you been googling? Initrd? Old udev? What about /dev/console
> > before udev starts?
>
> A quick googling preceded the email, indeed, but it lead to confusion.
> I am using mkinitrd, indeed.
> I updated udev to the latest version (udev-071-0.FC4.2).
> I didn't get get the point what you meant by
>
> "What about /dev/console before udev starts?"

I guess Jiri means something like this

http://forums.whirlpool.net.au/forum-replies.cfm?t=479931&r=7273347#r7273347

[yes, I am also using FC4 with Linus kernel and without initrd]

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
