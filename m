Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWHNPIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWHNPIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWHNPIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:08:41 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:30905 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S1751806AbWHNPIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:08:40 -0400
Message-ID: <44E09190.1040505@mauve.plus.com>
Date: Mon, 14 Aug 2006 16:06:56 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with latest kernels
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl> <200608141038.04746.gene.heskett@verizon.net>
In-Reply-To: <200608141038.04746.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
<snip>
> I'm having similar problems with an HP Pavilian dv5220, and with a 
> bluetooth mouse dongle plugged into the right side usb port it works just 
> fine.  What I'd like to do is totally disable that synaptics pad as its 
> way too sensitive, making it impossible to type more than a line or 2 

Enable the proper USB options, point X/GPM to /dev/input/mouse1 - or 
whatever.

It'd be nice if you could do this for keyboards too - but AIUI, you can't.
