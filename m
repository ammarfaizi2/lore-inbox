Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264218AbTCXPfQ>; Mon, 24 Mar 2003 10:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264245AbTCXPfQ>; Mon, 24 Mar 2003 10:35:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2730
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264218AbTCXPfP>; Mon, 24 Mar 2003 10:35:15 -0500
Subject: Re: PixelView video4linux driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Damian <ddalex_krn@easynet.ro>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7F1B6A.2000103@easynet.ro>
References: <Pine.LNX.4.53.0303211420170.13876@chaos>
	 <1048324118.3306.3.camel@LNX.iNES.RO>  <3E7F1B6A.2000103@easynet.ro>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048525157.25655.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 16:59:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 14:51, Alex Damian wrote:
>  I wrote a PixelView kernel video4linux module for CLGD5465-based tuner.
> Who is the maintainer of video4linux? . To whom should I submit the 
> driver for double-checking/ inclusion
> in the kernel ?

Gerd I guess. How are you handling the interlocking between the X server
and the tuner for registers ?

