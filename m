Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbTC0Gwv>; Thu, 27 Mar 2003 01:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262904AbTC0Gwv>; Thu, 27 Mar 2003 01:52:51 -0500
Received: from user-0can0ud.cable.mindspring.com ([24.171.131.205]:14721 "EHLO
	BL4ST") by vger.kernel.org with ESMTP id <S262903AbTC0Gwu>;
	Thu, 27 Mar 2003 01:52:50 -0500
Date: Wed, 26 Mar 2003 23:03:01 -0800
From: Eric Wong <eric@yhbt.net>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] Logitech USB mice/trackball extensions
Message-ID: <20030327070301.GA3953@BL4ST>
References: <200303261654.08896.bhards@bigpond.net.au> <200303261727.48908.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303261727.48908.bhards@bigpond.net.au>
Organization: Tire Smokers Anonymous
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards <bhards@bigpond.net.au> wrote:
> > Doing it in kernel space with module options is gross. This is clearly a
> > case for userspace.
> >
> > See:
> > http://www.linmagau.org/modules.php?name=Sections&op=viewarticle&artid=40
> 
> And for those who actually want the code:
> http://www.frogmouth.net/logitech-applet-0.2.tar.gz

Cool, works great!

-- 
Eric Wong
