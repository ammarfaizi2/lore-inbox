Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbTCTT3F>; Thu, 20 Mar 2003 14:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbTCTT3F>; Thu, 20 Mar 2003 14:29:05 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:30684 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261639AbTCTT3E>; Thu, 20 Mar 2003 14:29:04 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Oops with bttv in latest bk
Date: 20 Mar 2003 20:42:35 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87y939x1sk.fsf@bytesex.org>
References: <3E78BB99.3070605@portrix.net> <87he9z7z95.fsf@bytesex.org> <3E796530.2010707@portrix.net> <87znnqmitn.fsf@bytesex.org> <3E79ED9F.1000402@portrix.net>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1048189355 22970 127.0.0.1 (20 Mar 2003 19:42:35 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <j.dittmer@portrix.net> writes:

> bttv: driver version 0.9.7 loaded

Dammit, the must be yet another patch which can trigger that BUG().
I've already killed at least two of them ...

As it kills the X-Server I guess you are using the X-Servers v4l
module and the Xvideo extention, correct?

> Would it make sense to try as module? Currently it is compiled in.

I don't expect that makes a difference.

  Gerd

-- 
/join #zonenkinder
