Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264003AbTDNW6Q (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTDNW6Q (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:58:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12476
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264003AbTDNW6P (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:58:15 -0400
Subject: Re: Help with SiS 648 chipset and agpgart
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: tlee5794@rushmore.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304140439.08812.tlee5794@rushmore.com>
References: <200304140439.08812.tlee5794@rushmore.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050358311.26525.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 23:11:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 11:39, Tim Lee wrote:
> I need to get agpgart to work with a SiS 648 chipset and I
> haven't seen any implementation of such yet.  I'm currently
> using a 2.4.19 kernel.  Without a working implementation I
> can't use accelerated OpenGL with an ATI Radeon 9500 pro
> because the ATI drivers require working agp support.  I've
> tried just using the generic-sis but that causes the driver
> to mess up big time.

Currently no documentation is the problem. That may (fingers
cross) change soon. Until then sorry..

