Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275234AbTHAKzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275223AbTHAKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:53:08 -0400
Received: from 213-0-202-111.dialup.nuria.telefonica-data.net ([213.0.202.111]:33416
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S275216AbTHAKww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:52:52 -0400
Date: Fri, 1 Aug 2003 12:52:49 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test2-mm2 Still No Penguin Logo
Message-ID: <20030801105249.GA5762@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030801005737.72096.qmail@web13301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030801005737.72096.qmail@web13301.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 31 July 2003, at 17:57:37 -0700,
Ronald Jerome wrote:

> Logo has dissapeared after 2.6.0-test1-mm2.
> 
> I would have thought test2-mm2 would have patched the problem?
> 
The cute Tux penguin comes out of its cave each time I boot Linux
kernels 2.5.x+ since I started trying (and using) them. However, our
pretty friend comes sorrounded by a white band its own height, and all
the way to the right of the screen.

This is a box with a nVIDIA GeForce 2 MX based card:
01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX 100 DDR/200 DDR] (rev b2)

And the kernel (now 2.6.0-test2-mm2) is compiled with:
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_FB_RIVA=y

And the kernel is booted without passing it any vga= modes.

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test2-mm2)
