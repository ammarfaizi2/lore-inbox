Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbTF3SdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 14:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbTF3SdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 14:33:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48077 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265847AbTF3SdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 14:33:18 -0400
Date: Mon, 30 Jun 2003 20:47:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What did I miss?
Message-ID: <20030630184733.GI282@fs.tum.de>
References: <20030630161112.GB24137@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630161112.GB24137@rdlg.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 12:11:12PM -0400, Robert L. Harris wrote:
> 
> 2.4.21-ac3 kernel.  Compiling it without module support and alot of
> devices.  I'm getting this:
>...
>         -o vmlinux
> drivers/net/net.o(.data+0x854): undefined reference to `local symbols in
> discarded section .text.exit'
> make: *** [vmlinux] Error 1
> 
> 
> 
> (Please ignore CR wrapping by VI).
> 
> WTF is broken?  No obvious error messages outside a reference to net.o.
> I've tried enabling and removing different options but this doesn't seem
> to go away.  Any idea what option/driver is horked up?

Please send your .config.

> Robert

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

