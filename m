Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbTGZUin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbTGZUin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:38:43 -0400
Received: from dialpool-210-214-82-117.maa.sify.net ([210.214.82.117]:61825
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S269628AbTGZUii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:38:38 -0400
Date: Sun, 27 Jul 2003 02:24:47 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-freq P4 no sysfs interface
Message-ID: <20030726205447.GA4123@localhost.localdomain>
References: <20030726181233.GA2894@localhost.localdomain> <20030726202555.53eab2b5.florian.huber@mnet-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726202555.53eab2b5.florian.huber@mnet-online.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 08:25:55PM +0200, Florian Huber wrote:
> Hello Balram,
> 
> On Sat, 26 Jul 2003 23:42:33 +0530
> Balram Adlakha <b_adlakha@softhome.net> wrote:
> 
> > But there seems to be no cpu/ in /sysfs/class
> 
> It's in /sysfs/devices/system/cpu/* for me.
> 
> HTH
> 	Florian Huber

Hmm... Documentation says /sys/class/cpu. Thanks, I'll update the doc.


