Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbTCTKTG>; Thu, 20 Mar 2003 05:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTCTKTG>; Thu, 20 Mar 2003 05:19:06 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:1700 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261360AbTCTKTG>; Thu, 20 Mar 2003 05:19:06 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Oops with bttv in latest bk
Date: 20 Mar 2003 11:30:12 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87znnqmitn.fsf@bytesex.org>
References: <3E78BB99.3070605@portrix.net> <87he9z7z95.fsf@bytesex.org> <3E796530.2010707@portrix.net>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1048156212 5460 127.0.0.1 (20 Mar 2003 10:30:12 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <j.dittmer@portrix.net> writes:

> At least these algo-bits messages are gone. But still X restarts and
> tv image is corrupted until next reboot.
> 
> Jan
> 
> ------------[ cut here ]------------
> kernel BUG at drivers/media/video/bttv-risc.c:742!

Not reproducable here with latest bttv bits.  Sure you have the latest
module loaded?  bttv prints the version number at insmod time, should be
0.9.6 (vanilla 2.5.65 has 0.9.4 I think) ...

  Gerd

-- 
/join #zonenkinder
