Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272539AbTHNRGm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272566AbTHNRGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:06:42 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:16259 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272539AbTHNRGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:06:41 -0400
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Levon <levon@movementarian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030814165512.GA36329@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org>
	 <1060879622.5983.7.camel@dhcp23.swansea.linux.org.uk>
	 <20030814165512.GA36329@compsoc.man.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060880781.5983.9.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 14 Aug 2003 18:06:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-14 at 17:55, John Levon wrote:
> And then I'm stuck with no sensible way to figure out the kernel pointer
> size again... all user-space suggestions having the problems listed
> in this thread :

And why can't you put the pointer size at the start of the buffer ?
