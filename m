Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317480AbSGTTuB>; Sat, 20 Jul 2002 15:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317481AbSGTTuB>; Sat, 20 Jul 2002 15:50:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58609 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317480AbSGTTuA>; Sat, 20 Jul 2002 15:50:00 -0400
Subject: Re: Compile failure: 2.4.19-rc2-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: lostlogic@gentoo.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.44.0207191444120.14419-100000@gerber>
References: <Pine.GSO.4.44.0207191444120.14419-100000@gerber>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Jul 2002 22:04:58 +0100
Message-Id: <1027199098.16819.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-19 at 14:47, Alastair Stevens wrote:
> I was hoping to run a newer kernel because of the Athlon AGP "bug" fix,
> though I suspect that my max 2-day uptime problem is still down to the
> blasted nVidia driver :-(
> 
> Never mind, I'll try the next -ac release.
>
The -ac tree does not have the hacky Athlon AGP fix because
a) Everyone reporting the problem has the nvidia driver so I dont see
why I should suffer for them
b) Im waiting for the proper fix to be clean enough to merge


