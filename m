Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbUBBKfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUBBKfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 05:35:10 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:32963 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265336AbUBBKfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 05:35:06 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 2 Feb 2004 11:27:13 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ (ir-kbd-gpio.ko)
Message-ID: <20040202102713.GF26264@bytesex.org>
References: <20040201100644.GA2201@ucw.cz> <20040201215438.GA8937@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201215438.GA8937@localhost>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And from /proc/bus/input/devices:
> N: Name="bttv IR (card=41)"
> H: Handlers=kbd event3 

> I have downloaded LIRC from CVS (0.7.0pre1), tried to compile it with little 
> overall success, and started "lircd --device=/dev/lircd --nodaemon".

The device is /dev/input/event3.

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
