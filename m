Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130176AbRCESLl>; Mon, 5 Mar 2001 13:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130183AbRCESLb>; Mon, 5 Mar 2001 13:11:31 -0500
Received: from www.wen-online.de ([212.223.88.39]:4868 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130176AbRCESLZ>;
	Mon, 5 Mar 2001 13:11:25 -0500
Date: Mon, 5 Mar 2001 19:10:55 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loop stuck in -D state
In-Reply-To: <Pine.LNX.4.33.0103051844390.407-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0103051901580.558-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Mike Galbraith wrote:

> On Mon, 5 Mar 2001, Richard B. Johnson wrote:
>
> > I tried Linux 2.4.2
> > Now I'm in a load of trouble. I can't make a boot-disk to get back
> > to 2.4.1 because I use initrd for my hard disk modules and the loop
> > device is broken.
>
> What's wrong with 2.4.2 that makes you want to go back?  Anyway, if
> you grab Jens' patch, all will be peachy (at least for that kind of
> basic usage).

P.S.
Are you saying that the initrd is broken again as well?  (having
trouble understanding the problem.. don't see why you need the
loop device or rather how its being busted is connected to your
[interpolation] difficulty in creating a new initrd)

	-EAGAIN ;-)

	-Mike

