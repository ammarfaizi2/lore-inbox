Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWC2XFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWC2XFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWC2XFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:05:48 -0500
Received: from wproxy.gmail.com ([64.233.184.226]:14411 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751219AbWC2XFr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:05:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ejDkdLGvM3Eq/Zt3n4bY/LUsEbVfBvo4S+ZwlisqJvz1w2zAelW54AE2qL5qa9tFeDy/nLGFuBkbkY1X0rF3jy3h6g6hbwlrl4tcjHW7eNNIDvWJ9xoW6g3RR6aCF5Q4DGKyf2utPPKyOhp4ys8uZx4H2/SFTa78orK2vu+EYtY=
Message-ID: <9a8748490603291505h19be30b0ue454437c9aa1faac@mail.gmail.com>
Date: Thu, 30 Mar 2006 01:05:46 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Eric Persson" <eric@persson.tm>
Subject: Re: kernel config repository
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <442A99CA.20303@persson.tm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <442A99CA.20303@persson.tm>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/06, Eric Persson <eric@persson.tm> wrote:
> Hi,
>
> I hope I'm not totally wrong here, but I figured this would be a good
> place to start, the kernel-config list seems a bit dead.
>
> I've been thinking about creating a community-driven .config repository,
> since I havent found any good place for this sort of information.
> I would see it as a place for people to contribute .configs for various
> hardware/platforms and keep them updated and current with the kernel
> releases.
>
> Perhaps this exist(i havent found any easily), or is considered a bad
> idea(please tell me), or is actually a good idea.
>

For some users being able to grab a pre-made .config may be valuable,
but for most people I doubt it will be very useful. Peoples hardware
differ a lot, so a "best" config is always going to be one that you
tweak personally to match your system. If you don't want to do that
you are probably just going to use a generic distro kernel anyway (or
you could use the .config of the distro kernel with make oldconfig
when building a new kernel).

Maybe it's a good idea, dunno, but I don't really think so.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
