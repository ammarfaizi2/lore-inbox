Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbTCLUi1>; Wed, 12 Mar 2003 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261982AbTCLUi1>; Wed, 12 Mar 2003 15:38:27 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51655
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261980AbTCLUiZ>; Wed, 12 Mar 2003 15:38:25 -0500
Subject: Re: Linux 2.4.21pre5-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E6EF167.50409@myrealbox.com>
References: <fa.mpr04fi.1a4um8g@ifi.uio.no>  <3E6EF167.50409@myrealbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047506225.23725.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 21:57:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 08:35, walt wrote:
> No surprise, probably, but I'm still getting the kernel oops when
> I use swapoff on any partition which is not already mounted as a
> swap partition (i.e. what 'swapoff -a' attempts to do.)
> 
> I've already tried using very conservative CFLAGS for compiling
> both the kernel and util-linux with no improvement.
> 
> Any further information I can supply to help fix this?  Any
> other tricks I can try?

I've no idea what is going on in your case. The strace you sent me
only showed swapoff working properly

