Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSLMVKA>; Fri, 13 Dec 2002 16:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbSLMVKA>; Fri, 13 Dec 2002 16:10:00 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49617 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265400AbSLMVKA>; Fri, 13 Dec 2002 16:10:00 -0500
Date: Fri, 13 Dec 2002 22:17:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dean McEwan <dean.mcewan@eudoramail.com>
Cc: linux-kernel@vger.kernel.org, dean_mcewan@hotmail.com
Subject: Re: The Parallel port API- I need to write a device driver...!
Message-ID: <20021213211743.GF4817@fs.tum.de>
References: <JJKENKGENPBHAAAA@whowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JJKENKGENPBHAAAA@whowhere.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 01:13:04PM +0000, Dean McEwan wrote:

> Where can I find information on how to write a
> parallel port driver for a device im working on that 
> needs to connect to a parallel port, I don't want
> to write a driver for the parallel port just the device
> that uses it.
>...

  cd path_to_your_kernel_source
  make psdocs    # "htmldocs" and "pdfdocs" are available, too
  gv Documentation/DocBook/parportbook.ps

>  --- Cheers, Dean.

HTH
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

