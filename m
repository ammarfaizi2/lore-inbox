Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTAVShm>; Wed, 22 Jan 2003 13:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbTAVShm>; Wed, 22 Jan 2003 13:37:42 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:8431 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262425AbTAVShl> convert rfc822-to-8bit; Wed, 22 Jan 2003 13:37:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Richard J Moore <rasman@uk.ibm.com>
Organization: Linux Technoilogy Centre
To: Madhavi <madhavis@sasken.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel debugger
Date: Wed, 22 Jan 2003 18:06:14 +0000
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.33.0301211141580.8730-100000@pcz-madhavis.sasken.com>
In-Reply-To: <Pine.LNX.4.33.0301211141580.8730-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301221806.14885.rasman@uk.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 Jan 2003 6:17 am, Madhavi wrote:
If you need to debug a complex problem where stepping through or even 
pin-pointing roughtly the right code location then you might consider 
dprobes/kprobes.

Richard




> Hi
>
> I am currently testing a device driver on linux-2.4.19. This is
> implemented as a loadable kernel module.
>
> # Could anyone suggest a good debugger that can be used to debug kernel
>   modules?
>
> # When I tried using gdb with vmlinux and /proc/kcore, I am getting a
>   message saying that no debug symbols are found. How do I enable debug
>   symbols for linux kernel image? Kernel Debug is already enabled. Is
>   there some other configuration that needs to be there?
>
> Thanks in advance.
>
> regards
> Madhavi.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Richard J Moore
IBM Linux Technology Centre
