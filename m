Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSHNWlR>; Wed, 14 Aug 2002 18:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSHNWlR>; Wed, 14 Aug 2002 18:41:17 -0400
Received: from admin.nni.com ([216.107.0.51]:47624 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S315758AbSHNWlQ>;
	Wed, 14 Aug 2002 18:41:16 -0400
Date: Wed, 14 Aug 2002 18:44:07 -0400
From: Andrew Rodland <arodland@noln.com>
To: Stas Sergeev <stssppnn@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Message-Id: <20020814184407.4ca9e406.arodland@noln.com>
In-Reply-To: <3D5A8C2C.9010700@yahoo.com>
References: <3D5A8C2C.9010700@yahoo.com>
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002 20:58:20 +0400
Stas Sergeev <stssppnn@yahoo.com> wrote:

> Hello.
> 
> Denis Vlasenko wrote:
> >> The latest patch for 2.4.18 kernel
> >> is available here:
> >> http://www.geocities.com/stssppnn/pcsp.html
> > Tested. Works for playing MP3s.
> Thanks for your testing, indeed my primary
> goal was to make the sound quality acceptable
> even for playing MP3s.
> With the motherboard's output attached to an
> external speakers the quality is definitely
> acceptable, but for the internal beeper I am not
> shure if it is possible to really enjoy MP3s however:)

I can get some pretty decent sound out of it, but I also get some
horrible noise. Even if I send the driver a stream of zeroes, as soon
as it's opened it starts generating some horrible clicks and a
high-pitched whine.

Do I blame my motherboard (actually, a laptop)? Is there any way to fix
this, or at least improve it?
