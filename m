Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSDTWbM>; Sat, 20 Apr 2002 18:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSDTWbL>; Sat, 20 Apr 2002 18:31:11 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:13967 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313189AbSDTWbG>;
	Sat, 20 Apr 2002 18:31:06 -0400
Date: Sat, 20 Apr 2002 18:31:05 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Stevie O <stevie@qrpff.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420183105.B18057@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <5.1.0.14.2.20020420175004.00aa9288@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 06:00:36PM -0400, Stevie O wrote:
> (1) If I were to write a driver, and submit it for inclusion with
> the mainline kernel, would Linus be "censoring" me if he did not
> include my patch?

(IMO my answer fits for both these examples)


> (2) If I had such a driver included in mainline, and that driver
> broke in the 2.5 series -- due to, say, BIO changes, VFS changes,
> procfs changes, DMA changes, PCI subsystem changes, you get the
> idea -- and as a result, Linus chose to remove it from mainline,
> he's restricting the dissemination of my ideas (driver).  Does that
> mean he is censoring me?

In the strictest sense, yes.  But the key difference would be his
reasoning in your example would be technical, whereas Daniel's stated
reason was ideology.

One of the reasons why I like the Linux kernel is the freedom to make
the best technical decision, regardless of conflicting ideologies or
politics.

	Jeff



