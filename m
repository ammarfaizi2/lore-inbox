Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281324AbRKTTxa>; Tue, 20 Nov 2001 14:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281320AbRKTTxR>; Tue, 20 Nov 2001 14:53:17 -0500
Received: from mail.spylog.com ([194.67.35.220]:59084 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S281318AbRKTTxC>;
	Tue, 20 Nov 2001 14:53:02 -0500
Date: Tue, 20 Nov 2001 22:52:55 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15pre7: kernel: invalidate: busy buffer
Message-ID: <20011120225255.A6959@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <87itc5dysd.fsf@puck.erasmus.jurri.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87itc5dysd.fsf@puck.erasmus.jurri.net>
User-Agent: Mutt/1.3.23i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am use 2.4.15-pre5, hardware M/B Intel L440GX+ with onboard AIC7890.
After boot:

...
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
...

I use ext3.

Once you wrote about "2.4.15pre7: kernel: invalidate: busy buffer":
> After booting with 2.4.15pre7 for the first time, I got a screeful of
> messages saying: "invalidate: busy buffer".
> 
> From my syslog:
> 
> Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
> Nov 20 21:20:27 oberon last message repeated 55 times
> Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
> Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
> Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
> Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
> Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
> Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
> 
> Since I do not know what this should tell me, I'd appreciate if
> somebody told me what this is all about. I can, of course, provide
> more information if necessary. But since I don't have a clue on what
> this would be related to (other that the printk seems to be in
> buffer.c) I have no idea of what information might be useful.
> 
> Suonp??...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bye.
Andrey Nekrasov, SpyLOG.
