Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbTA1PDJ>; Tue, 28 Jan 2003 10:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbTA1PDI>; Tue, 28 Jan 2003 10:03:08 -0500
Received: from [81.2.122.30] ([81.2.122.30]:34565 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267353AbTA1PBf>;
	Tue, 28 Jan 2003 10:01:35 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281509.h0SF9sGV001368@darkstar.example.net>
Subject: Re: Bootscreen
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 28 Jan 2003 15:09:54 +0000 (GMT)
Cc: stepan@suse.de, raphael@arrivingarrow.net, linux-kernel@vger.kernel.org
In-Reply-To: <1043765442.8675.2.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Jan 28, 2003 02:50:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's not too much to even state that almost any computer working with
> > Linux 2.4+ can do 800x600 or 1024x768. Anything below that can be
> > considered a special case, regarding the numbers out there. But that
> > does not influence the possibility of using a bootsplash graphics. 
> > On a system you can't use it properly, you probably also would not 
> > want it (i.e. use normal text mode boot instead of a framebuffer
> > driver)
> 
> Lots of systems cannot do 800x600 or 1024x768. Some of them cannot
> do 640x480 very well but 640x480 is safe except for weird kit because
> of the VGA mode support.

Infact, better than using text mode with a custom font to draw a logo,
because some LCD screens display 720x400 as 640x400 by missing out one
pixel of each character.

John
