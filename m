Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSCZShI>; Tue, 26 Mar 2002 13:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312684AbSCZSg6>; Tue, 26 Mar 2002 13:36:58 -0500
Received: from 209-VALL-X7.libre.retevision.es ([62.83.213.209]:34823 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S312681AbSCZSgn>; Tue, 26 Mar 2002 13:36:43 -0500
Date: Tue, 26 Mar 2002 19:35:49 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Mark <mark@bish.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: C-Media 8738 sound driver + A7M266-D problems.
Message-ID: <20020326193549.A2476@ragnar-hojland.com>
In-Reply-To: <Pine.LNX.4.43.0203182216260.32113-100000@bish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 10:23:32PM -0500, Mark wrote:
> 
> I have a dual AMD board that has the 8738 onboard.  I compile 2.4.18 and
> pass it the '6 speaker' selection which should push the Rear speaker
> signal out the Line In connector and the Center Speaker Out/ Sub-woofer
> signal out the Mic In connector.  This does not happen.  I've tried this
> as a module and passing the params on the command line as well as
> compiling it directly into the kernel.  Am I missing something (very
> likely) or is this a known situation that I just have to deal with?

You could try version 2.75a from http://download.asus.com.tw/mb_dl_menu.asp

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."      [15 pend. Mar 10]
