Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTLACmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 21:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTLACmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 21:42:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45504 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263106AbTLACmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 21:42:04 -0500
Date: Mon, 1 Dec 2003 03:42:01 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Ryan Reich <ryanr@uchicago.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.22] Error: fs/fs.o: undefined reference to `atomic_dec_and_lock'
Message-ID: <20031201024200.GB24883@fs.tum.de>
References: <Pine.LNX.4.58.0311301925180.31444@ryanr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311301925180.31444@ryanr.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 07:28:03PM -0600, Ryan Reich wrote:

> I'm building a kernel with everything compiled in to serve as a boot image to
> install Mandrake on my laptop, and I get the following error:
>...
>         --end-group \
>         -o vmlinux
> fs/fs.o: In function `dput':
> fs/fs.o(.text+0x15f1c): undefined reference to `atomic_dec_and_lock'
> make: *** [vmlinux] Error 1

Does this problem still occur in 2.4.23?

If yes, please send your .config .

> Ryan Reich

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

