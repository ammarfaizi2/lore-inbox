Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319565AbSIMJCi>; Fri, 13 Sep 2002 05:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319566AbSIMJCi>; Fri, 13 Sep 2002 05:02:38 -0400
Received: from dsl-213-023-006-209.arcor-ip.net ([213.23.6.209]:64772 "HELO
	is1.blocksberg.com") by vger.kernel.org with SMTP
	id <S319565AbSIMJCh> convert rfc822-to-8bit; Fri, 13 Sep 2002 05:02:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre7
Date: Fri, 13 Sep 2002 11:07:21 +0200
User-Agent: KMail/1.4.2
References: <Pine.LNX.4.44.0209122313470.30211-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44.0209122313470.30211-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209131107.21391.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 04:18, Marcelo Tosatti wrote:
> So here goes -pre7. Big MIPS and IA64 merge.
>
> The on boot crashes with i845 should be fixed now.

hmm... i can't see any changes so far. i still have to use 
mem=exactmap mem=640K@0 mem=510M@1M

neither disgarding it complety nor using only mem=511M works.

it hangs right after  Ok, booting the kernel...

-- 
Best regards
Justin
