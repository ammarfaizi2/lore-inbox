Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTE1KBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbTE1KBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:01:53 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:41422 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264647AbTE1KBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:01:52 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: 2.5.70, drivers/media/video build errors
Date: 28 May 2003 12:20:01 +0200
Organization: SuSE Labs, Berlin
Message-ID: <87of1ne5ke.fsf@bytesex.org>
References: <Pine.LNX.4.44.0305270904430.7293-100000@dell>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1054117201 26177 127.0.0.1 (28 May 2003 10:20:01 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> writes:

>   CC      drivers/media/video/zr36120.o

needs update, not available yet as far I know.

>   CC      drivers/media/video/zr36067.o

Patches for that one exist, see http://bytesex.org/patches/2.5/ for
the .69 version (which doesn't apply cleanly to .70, update hopefully
shows up later today).

  Gerd

-- 
sigfault
