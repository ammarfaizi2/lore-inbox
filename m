Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2U50>; Mon, 29 Jan 2001 15:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRA2U5Q>; Mon, 29 Jan 2001 15:57:16 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:29551
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129101AbRA2U5I>; Mon, 29 Jan 2001 15:57:08 -0500
Date: Mon, 29 Jan 2001 21:56:54 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010129215654.D603@jaquet.dk>
In-Reply-To: <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> <Pine.LNX.4.31.0101292041390.22513-100000@athlon.local> <MKWhxB.A.jLF.Gfdd6@dinero.interactivesi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <MKWhxB.A.jLF.Gfdd6@dinero.interactivesi.com>; from ttabi@interactivesi.com on Mon, Jan 29, 2001 at 02:51:18PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 02:51:18PM -0600, Timur Tabi wrote:
> ** Reply to message from davej@suse.de on Mon, 29 Jan 2001 20:44:55 +0000 (GMT)
> 
> 
> > make pdfdocs
> 
> [ttabi@one DocBook]$ make pdfdocs
> Makefile:140: /Rules.make: No such file or directory

You have to be in the top level directory, not the DocBook one.

> 
> There's no Rules.make anywhere on my hard drive.

Made by 'make config'?

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"God prevent we should ever be twenty years without a revolution." 
  -- Thomas Jefferson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
