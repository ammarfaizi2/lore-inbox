Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275022AbRIYOrc>; Tue, 25 Sep 2001 10:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275023AbRIYOrW>; Tue, 25 Sep 2001 10:47:22 -0400
Received: from mail1.eznet.net ([209.105.128.6]:44306 "HELO mail1.eznet.net")
	by vger.kernel.org with SMTP id <S275022AbRIYOrM>;
	Tue, 25 Sep 2001 10:47:12 -0400
Message-ID: <3BB0998C.A3E41B7A@eznet.net>
Date: Tue, 25 Sep 2001 10:49:48 -0400
From: "David A. Frantz" <wizard@eznet.net>
Reply-To: wizard@eznet.net
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en-US, en, fr, es, ko, ja, de, nl, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.10 - problems with X
In-Reply-To: <Pine.GSO.4.04.10109251604130.23133-100000@mimosa>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent;

I happen to have XFree86 Version 4.0.2 installed.    What I was hoping to
do was to avoid an upgrade of the Windowing system, mostly because it has
been working well.    To avoid an upgrade of X, I did not enable DRI in the
kernel.   I thought that this along with a editing the XF86Config file
would have been enough to get the driver to work correctly.

Obviously this has not been the case.   It would be unfortunate if I had to
upgrade X just to get the kernel (2.4.10) to work.   Right now I'm going to
see if I can find a set of upgrade RPMS for X.   For a RedHat 6.2 this may
take a bit of work.

Dave


Vincent Vanackere wrote:

> What is your X version ? Did you upgrade X together with your kernel ?
>
> I had a similar problem here with a g400 which was in fact not
> kernel-related : I solved it by downgrading xserver-xfree86 from 4.1.0-6
> (debian/sid) to 4.1.0-5 (debian/testing).

