Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSLSSiR>; Thu, 19 Dec 2002 13:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265901AbSLSSiR>; Thu, 19 Dec 2002 13:38:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62443
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265898AbSLSSiR>; Thu, 19 Dec 2002 13:38:17 -0500
Subject: Re: 'D' processes on a healthy system?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin f krafft <madduck@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219182359.GA29366@fishbowl.madduck.net>
References: <20021219124043.GA28617@fishbowl.madduck.net>
	<1040319832.28973.4.camel@irongate.swansea.linux.org.uk> 
	<20021219182359.GA29366@fishbowl.madduck.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Dec 2002 19:27:11 +0000
Message-Id: <1040326031.28973.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 18:23, martin f krafft wrote:
> [please continue to CC me]
> 
> Thank you for your reply:
> 
> also sprach Alan Cox <alan@lxorguk.ukuu.org.uk> [2002.12.19.1843 +0100]:
> > Your disk is too slow for the work being asked of it, thats all.
> > Eventually it'll get there
> 
> Alan, I am in no position to doubt what you say, but I can't imagine
> that. Sure, maybe the 5,400 RPM one, but not the 7,200 RPM one.

Its more to do with the controller and configuration. Eg if your disk
isnt in DMA mode it'll certainly show up

