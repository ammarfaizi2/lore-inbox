Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTDGIDb (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTDGIDb (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:03:31 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:42190 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263317AbTDGID3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:03:29 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: does video for linux depend on I2C?
Date: 07 Apr 2003 10:21:21 +0200
Organization: SuSE Labs, Berlin
Message-ID: <87he9ayaym.fsf@bytesex.org>
References: <Pine.LNX.4.44.0304051436340.20539-100000@dell>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1049703681 2192 127.0.0.1 (7 Apr 2003 08:21:21 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> writes:

>  the help screen for I2C support claims that you need
> I2C for video for linux support.  however, it's still
> possible to not select I2C and yet select video for
> linux.

v4l subsystem itself doesn't need i2c, but some drivers do.

  Gerd

-- 
Michael Moore for president!
