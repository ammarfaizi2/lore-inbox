Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSFQWXS>; Mon, 17 Jun 2002 18:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSFQWXR>; Mon, 17 Jun 2002 18:23:17 -0400
Received: from monster.nni.com ([216.107.0.51]:23822 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317096AbSFQWXQ>;
	Mon, 17 Jun 2002 18:23:16 -0400
Date: Mon, 17 Jun 2002 18:21:37 -0400
From: Andrew Rodland <arodland@noln.com>
To: "James Stevenson" <mistral@stev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: invalidate: busy buffer
Message-Id: <20020617182137.5158103f.arodland@noln.com>
In-Reply-To: <000701c2164c$65630930$0501a8c0@Stev.org>
References: <000701c2164c$65630930$0501a8c0@Stev.org>
X-Mailer: Sylpheed version 0.7.6claws16 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002 23:14:48 +0100
"James Stevenson" <mistral@stev.org> wrote:

Something tried to wipe out all of the caches for some device, but
something else was using it at the time. For example, if you try to run
parted on something mounted (and bypass/confuse its mountedness check)
you'll see this. Were you doing anything like that?

> Hi
> 
> does anyone know what these mean ?
> 
> under
> 
> 2.4.19-pre8
> 
> invalidate: busy buffer
> 
> in the dmesg output
> got a bunch of these about 15 all together all of a sudden
> 
> 
> thanks
>     James
> 
> --------------------------
> Mobile: +44 07779080838
> http://www.stev.org
>  11:00pm  up 6 days, 10:21,  7 users,  load average: 0.04, 0.15, 0.12
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
