Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbSLJWNm>; Tue, 10 Dec 2002 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbSLJWNm>; Tue, 10 Dec 2002 17:13:42 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:12737 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266840AbSLJWNl>; Tue, 10 Dec 2002 17:13:41 -0500
Subject: Re: Oops on linux 2.4.20-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Orion Poplawski <orion@cora.nwra.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF6291C.3090100@cora.nwra.com>
References: <3DF6291C.3090100@cora.nwra.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 21:00:18 +0000
Message-Id: <1039554145.14175.70.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 17:49, Orion Poplawski wrote:
> I've been having a number of issues, mostly system lockups, with a 
> machine of ours - a dual proc athlon.  I've removed some hardware and I 

Random lockups on dual athlons are a notorious problem under all OS's.
Start by checking it passes memtest86, that will verify the RAM is ok -
and the AMD is -very- picky about RAM.

If thats ok then let me know which board you have, what is plugged into
it and what PSU you are using.


