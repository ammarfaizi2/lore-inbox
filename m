Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSFPGdX>; Sun, 16 Jun 2002 02:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSFPGdX>; Sun, 16 Jun 2002 02:33:23 -0400
Received: from adsl-216-62-201-136.dsl.austtx.swbell.net ([216.62.201.136]:58255
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S315941AbSFPGdW>; Sun, 16 Jun 2002 02:33:22 -0400
Subject: Re: how to find memory leak in the kernel?
From: Austin Gonyou <austin@digitalroadkill.net>
To: Sanjay Kumar <kumar_sanjai@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020616055754.9098.qmail@web9603.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 16 Jun 2002 01:32:31 -0500
Message-Id: <1024209151.26323.1.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a kernel profiler, have you checked FM for that? I've seen the
link there before. Also, is electric fence possible, or gprof? Never
tried them for kernel stuff...just a thought.

On Sun, 2002-06-16 at 00:57, Sanjay Kumar wrote:
> Hi, 
> 
> We are suspecting that our code in kernel is leaking memory.
> Please tell me some of available tools which I can use for
> finding the memory leak in kernel.
> 
> Thanks a lot.
> 
> Sanjay
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! - Official partner of 2002 FIFA World Cup
> http://fifaworldcup.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
