Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTLRJfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 04:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbTLRJfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 04:35:31 -0500
Received: from shadow02.cubit.at ([80.78.231.91]:14268 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S264974AbTLRJf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 04:35:27 -0500
Subject: Re: FrameBuffer Problem With 2.6.0
From: Andreas Unterkircher <unki@netshadow.at>
Reply-To: unki@netshadow.at
To: Armin <Zoup@zoup.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200312181254.23501.Zoup@zoup.org>
References: <200312181254.23501.Zoup@zoup.org>
Content-Type: text/plain
Message-Id: <1071740125.852.69.camel@winsucks>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Dec 2003 10:35:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had similar the same Problem... i fixed it when i also put the
compiled fonts in the kernel (vga fonts).

greetings, andi

Am Don, den 18.12.2003 schrieb Armin um 22:54:
> Hi list , 
> 
> im unble to get Framebuffer ( vesa fb ) working under 2.6 on 1024x768 ( 791 , 
> 790 , 731 and ... ) my card is ati mach64 , but frame buffer for this are not 
> working too ...
> 
> can anyone give me some tips about it ? everything but framebuffer are working 
> perfectly ! many thanks . 

