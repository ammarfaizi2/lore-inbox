Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVAKRR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVAKRR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVAKRQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:16:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:36564 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262861AbVAKRPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:15:03 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@gmail.com>
Cc: John Richard Moser <nigelenki@comcast.net>, znmeb@cesmail.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e99705011014197b8a9767@mail.gmail.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <1105045853.17176.273.camel@localhost.localdomain>
	 <1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net>
	 <1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net>
	 <1105278618.12054.37.camel@localhost.localdomain>
	 <41E1CCB7.4030302@comcast.net> <21d7e99705010917281c6634b8@mail.gmail.com>
	 <1105361337.12054.66.camel@localhost.localdomain>
	 <21d7e99705011014197b8a9767@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105456316.15742.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 11 Jan 2005 16:10:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 22:19, Dave Airlie wrote:
> kernel/userspace solution, and one is of little use without the other,
> if the kernel one is GPL and userspace one is closed source how do
> people sit with it? (uneasy?)

It would achieve nothing. It would still be undebuggable. We are far
better with the current R300 reverse engineering project until such a
point as ATI decide that R300 isn't valuable intellectual property any
more and will provide more information.

In many ways DRI is already superior on the older R2xx cards - it'll
play quake 3 without the computer crashing.

