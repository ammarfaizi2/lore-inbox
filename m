Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTDXOWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTDXOWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:22:45 -0400
Received: from pdbn-d9bb8734.pool.mediaWays.net ([217.187.135.52]:14090 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S263738AbTDXOWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:22:44 -0400
Date: Thu, 24 Apr 2003 16:34:33 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Pat Suwalski <pat@suwalski.net>
Cc: Werner Almesberger <wa@almesberger.net>,
       Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424143433.GA18374@citd.de>
References: <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424134904.GA18149@citd.de> <3EA7EFF5.3060900@suwalski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA7EFF5.3060900@suwalski.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:08:53AM -0400, Pat Suwalski wrote:
> Matthias Schniedermeyer wrote:
> >To be exact. ALSA mutes all channels, if you don't unset the mute-flags
> >on the channels you can increase the volume to 100% without a change.
> >:-)
> 
> Does it vary from hardware to hardware, distro to distro? On my machine, 
> the channels are most certainly not muted, only at 0.

Maybe it depends on hardware, or your mixer "transparently" unmutes the
channel when you increase volume.

At least with my sblive i can "mute" channels without changing the
volume level. And last time i tried ALSA the channels where muted.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

