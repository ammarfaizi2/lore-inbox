Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312495AbSC3TOa>; Sat, 30 Mar 2002 14:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312497AbSC3TOU>; Sat, 30 Mar 2002 14:14:20 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:45074 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312495AbSC3TOF>; Sat, 30 Mar 2002 14:14:05 -0500
Date: Sat, 30 Mar 2002 19:13:55 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5: bad config
Message-ID: <20020330191355.A26375@flint.arm.linux.org.uk>
In-Reply-To: <20020330090602.B23576@flint.arm.linux.org.uk> <E16rMvl-0003Oz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 05:46:21PM +0000, Alan Cox wrote:
> > It's basically to wrap it in an CONFIG_ARM and leave the SA1100 dependency.
> > Why?  There are other ARM PCMCIA drivers, and rather have a mass of if
> > statements, I'd rather see dep_*
> 
> dep_ won't work for this case. The ARM symbols are not set on non ARM boxes

I think you misread my email.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

