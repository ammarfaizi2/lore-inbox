Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264458AbTCXSX4>; Mon, 24 Mar 2003 13:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264465AbTCXSX4>; Mon, 24 Mar 2003 13:23:56 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:4778 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S264458AbTCXSXz>; Mon, 24 Mar 2003 13:23:55 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: PixelView video4linux driver
Date: 24 Mar 2003 19:36:25 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87ptog628m.fsf@bytesex.org>
References: <Pine.LNX.4.53.0303211420170.13876@chaos> <1048324118.3306.3.camel@LNX.iNES.RO> <3E7F1B6A.2000103@easynet.ro> <1048525157.25655.1.camel@irongate.swansea.linux.org.uk> <3E7F321A.1000809@easynet.ro>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1048530985 32071 127.0.0.1 (24 Mar 2003 18:36:25 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Damian <ddalex_krn@easynet.ro> writes:

> Alan Cox a scris:
> 
> >Gerd I guess. How are you handling the interlocking between the X server
> >
> I wrote the Gerd several times , but I got no replay... still trying

Into my personal mailbox?  Nothing arrived here ...
I've only seen the call-for-testers announcement on the v4l list.

> For now, you have to load the module after the X starts. Otherwise
> it stucks up (deadlock I think ).

Sounds like it needs some more work ...

  Gerd

-- 
/join #zonenkinder
