Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUBKN5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 08:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbUBKN5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 08:57:40 -0500
Received: from denise.shiny.it ([194.20.232.1]:38879 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S264374AbUBKN5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 08:57:39 -0500
Date: Wed, 11 Feb 2004 14:57:30 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Peter Lieverdink <peter@cc.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 PPC ALSA snd-powermac
In-Reply-To: <1076483508.13791.6.camel@kahlua>
Message-ID: <Pine.LNX.4.58.0402111450290.1726@denise.shiny.it>
References: <1076483508.13791.6.camel@kahlua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Feb 2004, Peter Lieverdink wrote:

> Is it just me or does 'make menuconfig' in kernel 2.6.2 on ppc not give
> me an option to enable i2c? It's supposed to be in Character Devices,
> no? The ALSA snd-powermac module needs i2c and upon a 'modprobe
> snd-powermac' spews forth:

Yes, it is there IIRC (I'm not at home, I can't verify). But I don't know
if the official kernel is up to date with all macintosh stuff. I'm using
2.6.2-benh1 and the option to enable i2c exists and works fine.
http://www.penguinppc.org/dev/kernel.shtml


--
Giuliano.
