Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290654AbSARK1S>; Fri, 18 Jan 2002 05:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290656AbSARK1I>; Fri, 18 Jan 2002 05:27:08 -0500
Received: from dpt-info.u-strasbg.fr ([130.79.44.193]:23562 "EHLO
	dpt-info.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S290654AbSARK07>; Fri, 18 Jan 2002 05:26:59 -0500
Date: Fri, 18 Jan 2002 11:26:40 +0100
From: Sven <luther@dpt-info.u-strasbg.fr>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
Message-ID: <20020118112640.A23763@dpt-info.u-strasbg.fr>
In-Reply-To: <Pine.LNX.4.10.10201151702130.31251-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10201151702130.31251-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Tue, Jan 15, 2002 at 05:07:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 05:07:00PM -0800, James Simmons wrote:
> 
> Hi folks!!
> 
>     On to the massive fbdev cleanup. The second patch requires the first
> patch. The first patch is the currcon one that I posted earlier. Every

Mmm, what is the current status on all this.

How does the new fbdev api compare with ruby, is it the same thing or not, and
how does the ruby tree compare with the -dj one ?

And what is the current status of fbdev in 2.5.x ? 2.5.1 + ruby hang my box
early in the boot process, but that is probably because pm3fb is not working
yet for ruby. Does matroxfb work ? i have an older pci matrox board that i
could install to test and do some pm3fb work if needed (and if i get the time
for it :(((0

Friendly,

Sven Luther
