Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTKAGXM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 01:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTKAGXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 01:23:12 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:37381 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S263726AbTKAGXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 01:23:10 -0500
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Javier Villavicencio <jvillavicencio@arnet.com.ar>
In-Reply-To: <1067587196.715.1.camel@gaston>
References: <20031029210321.GA11437@dreamland.darkstar.lan>
	<1067491238.1735.4.camel@ktkhome>  <1067587196.715.1.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 01 Nov 2003 01:22:43 -0500
Message-Id: <1067667765.1642.10.camel@ktkhome>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-31 at 02:59, Benjamin Herrenschmidt wrote:
> Can you verify that running fbset -accel 0 then back 1 cures the
> problem for you ?

Hi Ben -

Tried it, no effect.  It did not seem to do a reset of the card; sync
never hiccupped.  I also set the mode to a different one and back; that
had no effect, either.  I'm using fbset 2.1 from the linux-fbdev site.

As for the YPAN problem, I have the screen set to 1280x1024 using the
sun 22x12 font.

Kris

