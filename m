Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313946AbSDZM5m>; Fri, 26 Apr 2002 08:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313938AbSDZM5m>; Fri, 26 Apr 2002 08:57:42 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:56647 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313930AbSDZM5l>; Fri, 26 Apr 2002 08:57:41 -0400
Date: Fri, 26 Apr 2002 12:56:55 +0000
From: "Roeland Th. Jansen" <scsi@grobbebol.xs4all.nl>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: BT930 + old scsi disk
Message-ID: <20020426125655.A1961@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi *


I have a BT930 controller; works fine for all scsi disks I have ..
except one..


there is one disk that for the second time has killed the system.


First time I was not at the system when it happened. This time I was.

I heard the following sound (yep, technical ahum) :

click
downspin....
click
upspin......

it was maybe only 3 seconds. but the system froze completely; numlock
leds etc were ok, but magic sysrq didn't work (??)

also, no way I could remotely log onto the system anymore.

At this point, as it's a datadisk, I have taken it off the scsi bus to
prevent further bad things to happen.

unfortunately, there was nothing regarding the scsi controller or disk
in the log.


any ideas what I could do to help preventing this ? (seems somewhere a
bug in the kernel/bt930 ?)



Roeland

