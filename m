Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129310AbRBSV6q>; Mon, 19 Feb 2001 16:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBSV6g>; Mon, 19 Feb 2001 16:58:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:34573 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129310AbRBSV6B>;
	Mon, 19 Feb 2001 16:58:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [LONG RANT] Re: Linux stifles innovation... 
In-Reply-To: Your message of "Mon, 19 Feb 2001 10:58:36 CDT."
             <Pine.LNX.3.95.1010219101720.30581A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Feb 2001 08:57:54 +1100
Message-ID: <32690.982619874@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001 10:58:36 -0500 (EST), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>I was unable to use the new kernel because the drivers I need for
>`initrd` all had undefined symbols relating to some high memory stuff.
>This, in spite of the fact that I did:
>
>cp .config ..
>make clean
>make distclean
>cp ../.config
>make oldconfig
>make dep
>make bzImage
>make modules
>make modules_install

FAQ: http://www.tux.org/lkml/#s8-8

