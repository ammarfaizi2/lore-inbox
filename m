Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbTDFWJA (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTDFWI7 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:08:59 -0400
Received: from pop.gmx.de ([213.165.65.60]:32082 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263144AbTDFWI6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 18:08:58 -0400
Message-ID: <3E90A829.6060601@gmx.net>
Date: Mon, 07 Apr 2003 00:20:25 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Fredrik Jagenheim <fredde@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Maestro sound module locks up the computer
References: <20030406193707.GG917@pobox.com>
In-Reply-To: <20030406193707.GG917@pobox.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fredrik Jagenheim wrote:
> When playing music through the maestro sounddriver, the computer will lock up
> at irregular intervals. These lock ups will cause the entire machine to freeze,
[...]
> I've narrowed it down (I think) to the maestro driver as these lockups only
> happen when I play music. It doesn't matter if I use mplayer from console, or
> xmms from X, the lockups still happen. These lockups doesn't happen if I don't
> play music, so...

Maybe I have a similar problem. ESS Maestro 2E, OSS maestro.o driver, 
kernel 2.4.18 (and all versions since 2.4.0), Toshiba 4100XCDt laptop. 
However, here first the sound becomes somehow distorted and a few 
minutes later the machine just powers off. For me, it looks like a 
hardware failure because the same problem was visible when I got the 
machine with WinNT preinstalled.

Could you please tell me if sound is distorted before the "hangs"? In 
that case, try pausing the output and then continue playing. The 
distortion should disappear and you should be safe from hangs until the 
next distortion period.

Regards,
Carl-Daniel

-- 
http://www.hailfinger.org

