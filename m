Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRA2Up0>; Mon, 29 Jan 2001 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRA2UpR>; Mon, 29 Jan 2001 15:45:17 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:49132 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129172AbRA2UpK>; Mon, 29 Jan 2001 15:45:10 -0500
Date: Mon, 29 Jan 2001 20:44:55 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
cc: John Levon <moz@compsoc.man.ac.uk>, Timur Tabi <ttabi@interactivesi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.31.0101292041390.22513-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, David D.W. Downey wrote:

> Simply put, with all bitterness and finger pointing aside, WHERE do we
> find information on various kernel functions, their general usage (as in
> the WHY, not only the HOW) and reasonings on why not to use some
> vs. others.

/usr/src/linux/Documentation

> Me personally, I'd be happy with a list of all the finctions in the linux
> kernel, a brief description of their usage and a singl elink on where to
> find more info about that particular function.

make pdfdocs
acroread Documentation/DocBook/kernel-api.pdf

(Check out the other .pdf's in that dir too)

You may also make sgmldocs/psdocs/htmldocs

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
