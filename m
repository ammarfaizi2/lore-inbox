Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291216AbSBSLHy>; Tue, 19 Feb 2002 06:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291214AbSBSLHr>; Tue, 19 Feb 2002 06:07:47 -0500
Received: from mail2.alphalink.com.au ([202.161.124.58]:51820 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S291236AbSBSLHC>; Tue, 19 Feb 2002 06:07:02 -0500
Message-ID: <3C72232C.6106C018@alphalink.com.au>
Date: Tue, 19 Feb 2002 21:04:28 +1100
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Michal Jaegermann <michal@harddata.com>
Subject: Re: Disgusted with kbuild developers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

Michal Jaegermann <michal@harddata.com> wrote:
>
> I also cannot help not to notice that the previous bit flare-up about
> CML2 on lkml was quelled to a great extent when somebody annouced that
> he is rewriting required tools in C.

  I believe I'm the anonymous `he' you refer to.

>  I had an impression that most
> people then shrugged "Ok, so Eric will prototope in whatever he feels
> comfortable with, we will have something acceptable later and we will
> see how this works".

  I had the impression that most people just stopped whingeing on lkml
but didn't actually try the code.  I've had very very little feedback
or apparent interest on gcml2.  In the meantime ESR's Python code got
less buggy and faster and I upgraded my main devel box to a distro
which had Python2 on it.  The Python code had limped up to the `adequate'
mark and my time is finite so I moved on.

  Look if I thought gcml2 was a serious contender to be used as the kernel
config tool of choice I would drop everything else and finish it.

>  Now it turns out the the project got abandoned [...] Hm..., smells
> very backdoor even if it was not intended that way. 

  So you're implying that I colluded with ESR to use gcml2 as a decoy
to ease acceptance of his Python2 implementation?  Hah, I *wish* I was
that organised or devious!

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.	   - Roger Sandall, The Age, 28Sep2001.
