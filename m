Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbTDIQDZ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbTDIQDZ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:03:25 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64390 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261474AbTDIQDY (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 12:03:24 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [Bug 563] New: Build failure at drivers/media/video/zr36120.c
Date: 09 Apr 2003 18:20:47 +0200
Organization: SuSE Labs, Berlin
Message-ID: <87k7e3y74w.fsf@bytesex.org>
References: <190330000.1049902398@[10.10.2.4]>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1049905247 13034 127.0.0.1 (9 Apr 2003 16:20:47 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

>            Summary: Build failure at drivers/media/video/zr36120.c
>     Kernel Version: 2.5.67
>             Status: NEW

Ahem, that isn't NEW, it doesn't for ages ...

Fix (which is a major rewrite of the zoran driver, done by Ronald
Bultje) exists, see http://bytesex.org/patches/2.5/, will go to Linus
with the next batch of v4l updates.

  Gerd

-- 
Michael Moore for president!
