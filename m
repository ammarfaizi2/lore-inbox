Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312690AbSDKRtt>; Thu, 11 Apr 2002 13:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312691AbSDKRts>; Thu, 11 Apr 2002 13:49:48 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:20694 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S312690AbSDKRts>; Thu, 11 Apr 2002 13:49:48 -0400
Date: Thu, 11 Apr 2002 17:49:42 +0000
From: "John P. Looney" <john@antefacto.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020411174941.GC17962@antefacto.com>
Reply-To: john@antefacto.com
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020411154601.GY17962@antefacto.com> <20020411164331.GR612@gallifrey> <20020411184923.A15238@ucw.cz> <20020411170910.GS612@gallifrey> <20020411191339.B15435@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-URL: http://www.redbrick.dcu.ie/~valen
X-GnuPG-publickey: http://www.redbrick.dcu.ie/~valen/public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 07:13:39PM +0200, Vojtech Pavlik mentioned:
> > I'd presumed this was
> > the whole point of the busid spec in the config file.
> No, it's for running one Xserver on multiple displays at once only.
> Sad, ain't it?

 Very sad. Nice to know it's not really the kernel's fault. 

 Is it possible to say "Any mice plugged in to this port is
/dev/input/mouse3" etc. so that if someone plugged out your mouse, plugged
in another into a different port, and you plugged yours back in, that they
wouldn't renumberate ?

Kate
 
-- 
_______________________________________
John Looney             Chief Scientist
a n t e f a c t o     t: +353 1 8586004
www.antefacto.com     f: +353 1 8586014

