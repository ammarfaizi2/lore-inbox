Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279603AbRK0Nvk>; Tue, 27 Nov 2001 08:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279627AbRK0Nvb>; Tue, 27 Nov 2001 08:51:31 -0500
Received: from olvs.miee.ru ([194.226.0.69]:13741 "EHLO olvs.miee.ru")
	by vger.kernel.org with ESMTP id <S279722AbRK0NvU>;
	Tue, 27 Nov 2001 08:51:20 -0500
Message-ID: <3C039A4C.9050204@mail.ru>
Date: Tue, 27 Nov 2001 16:51:08 +0300
From: Sergei Pachkov <spigel@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: ru, en, de-de
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: latest 2.4 kernels freeze after uncompressing linux
In-Reply-To: <1006862198.5581.0.camel@hecate>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try to modify 'lilo.conf' for new kernel and run 'lilo' now.

Eamonn Hamilton wrote:

>
>Hi Guys.
>
>I'm setting up a machine for a friend, and I've got a weird problem.
>
>On a motherboard ( and old M571 I think )  with a Cyrix 686L processor I
>can't boot any of the recent series of kernels. When booting, I get the
>loading Linux and tye uncpressing stage, but it then locks solid. It
>looks like the bzimage problem that was around a good long while ago,
>however I CAN boot 2.2.15 which is also a bzImage. I've tried compiling
>the kernels as i386, as well as 586, and I've also tried the debian
>dstrbution kernels ( it's debian unstable, by the way ).
>
>Anybody got any ideas?
>
>Chers,
>Eamonn
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


