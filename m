Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbTDXPuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTDXPuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:50:25 -0400
Received: from almesberger.net ([63.105.73.239]:32265 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261474AbTDXPuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:50:25 -0400
Date: Thu, 24 Apr 2003 13:01:51 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Pat Suwalski <pat@suwalski.net>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424130151.O3557@almesberger.net>
References: <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424134904.GA18149@citd.de> <3EA7EFF5.3060900@suwalski.net> <20030424143433.GA18374@citd.de> <20030424120403.N3557@almesberger.net> <20030424152303.GA18573@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424152303.GA18573@citd.de>; from ms@citd.de on Thu, Apr 24, 2003 at 05:23:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> man amixer

Thanks. Yes, this indeed seems to map to some functionality that's
understood by the kernel.

Strange. So does this mean that non-ALSA mixers should not work when
using ALSA ? Why do they seem to anyway ? Is the driver or hardware
side of this mute flag just rarely implemented ? Or is the kernel
default not always "mute" ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
