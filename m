Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263240AbTCSWYT>; Wed, 19 Mar 2003 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbTCSWYT>; Wed, 19 Mar 2003 17:24:19 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:7050 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263240AbTCSWYG>; Wed, 19 Mar 2003 17:24:06 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Oops with bttv in latest bk
Date: 19 Mar 2003 23:44:22 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87he9z7z95.fsf@bytesex.org>
References: <3E78BB99.3070605@portrix.net>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1048113862 27617 127.0.0.1 (19 Mar 2003 22:44:22 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <j.dittmer@portrix.net> writes:

> Starting 'zapping' (Gnome TV application, Version V0.6.6-1 from Debian
> unstable) gives the following error and an immediate X restart.
> The overlay window is corrupted afterwards till next reboot.
> Don't know, when this was introduced - it was the first time I ever
> started it, but there weren't any changes lately so I suppose this was
> in longer. Xawtv is working fine.
> Linux is latest 2.5.65 from bk.
> Is there anything specific I could try?

http://bytesex.org/patches/2.5/patch-2.5.65-kraxel.gz

  Gerd

-- 
/join #zonenkinder
