Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312986AbSDBWmY>; Tue, 2 Apr 2002 17:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSDBWmG>; Tue, 2 Apr 2002 17:42:06 -0500
Received: from h53n2fls32o986.telia.com ([213.67.49.53]:23813 "EHLO
	localhost.toothpaste.org") by vger.kernel.org with ESMTP
	id <S312980AbSDBWl4>; Tue, 2 Apr 2002 17:41:56 -0500
Date: Wed, 3 Apr 2002 01:38:42 +0200
From: Erik =?ISO-8859-1?Q?Ljungstr=F6m?= <insight@metalab.unc.edu>
To: Chris Rankin <rankincj@yahoo.com>
Cc: VANDROVE@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-Id: <20020403013842.54a961e2.insight@metalab.unc.edu>
In-Reply-To: <3CAA25E7.2060405@yahoo.com>
Organization: Independent C0der
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Apr 2002 22:43:03 +0100
Chris Rankin <rankincj@yahoo.com> wrote:

> Hi,
> 
> I have an i840 motherboard with dual 733 MHz PIIIs and a Matrox G400 
> MAX, and I am also seeing console corruption with 2.4.18. The difference 
> with me is that I *only* see it when I am using xine (CVS) and the 
> SyncFB video plugin, possibly the Xv video plugin sometimes too. When I 
> kill xine, the regular multicoloured rectangle disappears from the console.
> 
> Obviously, this isn't something that I would normally notice - I 
> wouldn't have noticed at all if the CVS xine hadn't locked up on me in 
> full-screen mode, forcing me to turn to a console to kill it.
> 
> A few other things:
> - since I have about 1.25 GB of RAM, I have enabled a 256 MB AGP aperture.
> - I am using XFree86 4.2, but with the mga.o module that is native to 
> Linux 2.4.18. I have not installed the Matrox HAL X module.
> 
> Whatever is causing this console corruption, it doesn't seem to be a VIA 
> bug (in my case, anyway).
> 
> Chris
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I'm having the same problem, just that this happens when I've been using mplayer with the -vo vesa parameters. I also have this problem with the 2.4.17 kernel.
-- 
--
Best regards, Erik
