Return-Path: <linux-kernel-owner+w=401wt.eu-S932345AbWLQSb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWLQSb5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWLQSb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:31:57 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:33266 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbWLQSb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:31:57 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45858CF2.7080402@s5r6.in-berlin.de>
Date: Sun, 17 Dec 2006 19:31:14 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <45818E6E.8020505@s5r6.in-berlin.de> <200612142217.44840.gene.heskett@verizon.net> <200612171311.38763.gene.heskett@verizon.net>
In-Reply-To: <200612171311.38763.gene.heskett@verizon.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
...
> while I didn't try 
> to capture a 2 hour movie, I did use kino to control the camera playback, 
> rewind etc stuff for about 10 minutes and had no problems whatsoever.
...
> The only entry in the messages log for all this was:
> 
> Dec 17 12:47:13 coyote kernel: WARNING: The dv1394 driver is unsupported 
> and will be removed from Linux soon. Use raw1394 instead.

Is your version of kino still using dv1394 or does it work without
dv1394 loaded too?

> Dec 17 12:47:13 coyote kernel: ieee1394: raw1394: /dev/raw1394 device 
> initialized
> 
> So whatever was done to the ieee1394 stuffs between 2.6.19 and 2.6.20-rc1 
> was a definite, and much appreciated improvement,
...

>From what went into linux/drivers/ieee1394 after 2.6.19 was released,
I'm puzzled how this happened. :-)
-- 
Stefan Richter
-=====-=-==- ==-- =---=
http://arcgraph.de/sr/
