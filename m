Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273349AbRINJ0U>; Fri, 14 Sep 2001 05:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273347AbRINJ0A>; Fri, 14 Sep 2001 05:26:00 -0400
Received: from [211.48.62.161] ([211.48.62.161]:19891 "EHLO relay1.kornet.net")
	by vger.kernel.org with ESMTP id <S271989AbRINJZ4>;
	Fri, 14 Sep 2001 05:25:56 -0400
Date: Fri, 14 Sep 2001 18:26:15 +0900
From: Jeff Lightfoot <jeffml@pobox.com>
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Message-Id: <20010914182615.50f72943.jeffml@pobox.com>
In-Reply-To: <Pine.GSO.4.21.0109140523060.3130-100000@jacui>
In-Reply-To: <Pine.GSO.4.21.0109140430540.2204-100000@jacui>
	<Pine.GSO.4.21.0109140523060.3130-100000@jacui>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001 05:27:49 -0300 (EST)
Roberto Jung Drebes <drebes@inf.ufrgs.br> wrote:

> I tested here and it seems that bit 7 is responsible. Here is the diff
> to pci-pc.c:

[snip patch]

I tried it with my IWill 266 Plus and Althon 1.4G

Things now boot up normally with Athlon Optimizations turned on.

Before this, those same optimizations would produce oops galore on
system startup.

Let me know if you want more system info.

-- 
Jeff Lightfoot   --    jeffml at pobox.com   --   http://thefoots.com/
    "How can I sing like a girl and not be stigmatized by the rest of
    the world?" -- TMBG
