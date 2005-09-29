Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVI2XuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVI2XuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVI2XuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:50:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932300AbVI2XuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:50:23 -0400
Date: Thu, 29 Sep 2005 16:49:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
Message-Id: <20050929164939.5329d6f0.akpm@osdl.org>
In-Reply-To: <5bdc1c8b050929162689415dd@mail.gmail.com>
References: <20050929143732.59d22569.akpm@osdl.org>
	<5bdc1c8b050929162689415dd@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Knecht <markknecht@gmail.com> wrote:
>
> On 9/29/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
> >
> > (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
> >
> 
> Hi,
>    I'm semi-sure at this point that the xrun problems I'm seeing on my
> AMD64/NForce4 machine (Asus A8N-E motherboard) are isolated to the
> SATA drive. Is there anything here that might address that? I'm
> currently running 2.6.14-rc2-mm1. I've got this machine headless at
> the moment. I can move data reliably using the CDRW drive, the DVD
> drive with xine, and I can copy lots of data off and on my 1394
> drives. I can run Ardour, Aqualung and lots of other apps remotely
> using this machine as a server. When I start using the SATA drive,
> read or write, I get lots xruns.
> 

What is an xrun?
