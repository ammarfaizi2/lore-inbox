Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTH0QNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTH0QLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:11:49 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:9377 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263610AbTH0QKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:10:46 -0400
Subject: Re: [PATCH] fix 2.6.0-test4 IDE warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0308241248130.14076-100000@waterleaf.sonytel.be>
References: <Pine.GSO.4.21.0308241248130.14076-100000@waterleaf.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062000598.22739.80.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 17:09:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-24 at 11:49, Geert Uytterhoeven wrote:
> Alan rejected this a while ago. He said he'd more like the speed parameter
> become an int, but that that would require more changes.

Right but its up to Bart for 2.6 now 8)

