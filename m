Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRKRQa4>; Sun, 18 Nov 2001 11:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279891AbRKRQaq>; Sun, 18 Nov 2001 11:30:46 -0500
Received: from marao.utad.pt ([193.136.40.3]:13328 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S279865AbRKRQal> convert rfc822-to-8bit;
	Sun, 18 Nov 2001 11:30:41 -0500
Subject: Re: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
From: Alvaro Lopes <alvieboy@alvie.com>
To: "Michael N. Lipp" <MNL@MNL.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200111171745.fAHHjnZ02112@mnlpc.dtro.e-technik.tu-darmstadt.de>
In-Reply-To: <200111171745.fAHHjnZ02112@mnlpc.dtro.e-technik.tu-darmstadt.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 18 Nov 2001 16:29:36 +0000
Message-Id: <1006100978.891.4.camel@dwarf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sáb, 2001-11-17 at 17:45, Michael N. Lipp wrote:
> Hello,
> 
> when I upgraded to 2.4.14, I found that console-switching doesn't work
> anymore with the latest NVIDIA driver installed. When I try to return
> to the console from X11 the system simply hangs (this includes
> shutdown, which makes it a real problem). Reverting to 2.4.13 fixed

Well I have the same kind of problem. But you don't have to shutdown!
Just switch again to your X vt, and X should work again.

> things. Sorry I can't report more hints.
> 
> Regards,
> 
>     Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


