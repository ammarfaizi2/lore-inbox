Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269965AbRHNL27>; Tue, 14 Aug 2001 07:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270567AbRHNL2t>; Tue, 14 Aug 2001 07:28:49 -0400
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:63453 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269965AbRHNL2d>; Tue, 14 Aug 2001 07:28:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Paul Jakma <paulj@alphyra.ie>
Subject: Re: via82cxxx_audio driver bug?
Date: Tue, 14 Aug 2001 04:28:17 -0700
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108141203040.15241-100000@dunlop.itg.ie>
In-Reply-To: <Pine.LNX.4.33.0108141203040.15241-100000@dunlop.itg.ie>
MIME-Version: 1.0
Message-Id: <01081404281700.05063@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 August 2001 04:06 am, Paul Jakma wrote:
> On Mon, 13 Aug 2001, Nicholas Knight wrote:
> > The UI in other apps is a little iffy on my end, sometimes they lock,
> > sometimes not.
>
> well.. even mpg123 seems to suffer. it doesn't have a UI :) but it
> doesn't respond to ^C straight away.

I'll try to monitor CPU usage of XMMS when /dev/mixer is avalible to it

>
> > what version was in kernel 2.4.3? I first started reporting this when
> > I installed Mandrake 8.0 and noticed it a couple months ago.
>
> i honestly don't remember.
>
> Jeff has a newer driver out, 1.1.15, i didn't get a chance to try it
> out last night. wondering whether it fixes the problem. (it has a lot
> of fixups).

nope, I've already tried it, same problems :(

>
> regards,
>
> --paulj
