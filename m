Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275503AbTHNUmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275504AbTHNUmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:42:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11276 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275503AbTHNUmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:42:40 -0400
Date: Thu, 14 Aug 2003 21:42:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Eli Carter <eli.carter@inet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Message-ID: <20030814214236.F332@flint.arm.linux.org.uk>
Mail-Followup-To: Eli Carter <eli.carter@inet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org> <1060879622.5983.7.camel@dhcp23.swansea.linux.org.uk> <3F3BED30.90904@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F3BED30.90904@inet.com>; from eli.carter@inet.com on Thu, Aug 14, 2003 at 03:12:32PM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 03:12:32PM -0500, Eli Carter wrote:
> Alan Cox wrote:
> > Now if you'd agree to merge the kgdb stubs to replace it.... ;)
> 
> No, that isn't something I can take on. :/  (Though I did get it 
> partially working on 2.5 XScale.)

George Davis did some work in this area.  I'm not sure what state it's
in though.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=1335/1

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

