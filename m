Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271155AbTG2GdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 02:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271284AbTG2GdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 02:33:09 -0400
Received: from [213.69.232.58] ([213.69.232.58]:16136 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S271155AbTG2GdC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 02:33:02 -0400
Date: Tue, 29 Jul 2003 00:13:23 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Andries.Brouwer@cwi.nl
Cc: nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: psmouse: synaptics (2.6.0-test1|2)
Message-ID: <20030728221323.GC10741@schottelius.org>
References: <UTC200307281608.h6SG8oY24499.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <UTC200307281608.h6SG8oY24499.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux pinguin-02 2.4.18
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl [Mon, Jul 28, 2003 at 06:08:50PM +0200]:
> > My touchpad stops working with 2.5.74.
> 
> You mean it worked in 2.5.73 but not in 2.5.74?

more correct it was 2.5.72. 

> > howto get gpm running?
> 
> Ask the gpm maintainer.

*wonder* 'how do i get gpm running?' (look at linux.schottelius.org/gpm/) 
the problem is I currently recieve _no_ data from psaux.
no init response. nothing.


> > what source of information do you use?
> 
> Vendor docs. User reports. Yes, reports from you.

and you try / want to implement whole gpm in the kernel? (without the
bugs we have....)

Nico

-- 
echo God bless America | sed 's/.*\(A.*$\)/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new
