Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbTDBEnb>; Tue, 1 Apr 2003 23:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbTDBEnb>; Tue, 1 Apr 2003 23:43:31 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:32153 "EHLO
	zachery.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261610AbTDBEna>; Tue, 1 Apr 2003 23:43:30 -0500
Date: Tue, 1 Apr 2003 23:54:39 -0500
From: Ben Collins <bcollins@debian.org>
To: Miek Gieben <miekg@atoom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre6 and usb-uhci
Message-ID: <20030402045439.GW28258@phunnypharm.org>
References: <20030401093646.GA11420@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401093646.GA11420@atoom.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 11:36:46AM +0200, Miek Gieben wrote:
> Hello,
> 
> [ i'm not subscribed, so please cc me on any follow ups]
> 
> with kernel 2.4.21-pre6 my usb mouse stopped working (actually all usb stuff
> stopped working). It's a logitech optical mouse which worked perfectly under
> -pre5. I'm using the usb-uhci module.  I get no failures are anything of that

I get the same problem. This includes a Logitech keyboard, two joysticks
and a Linksys WUSB11 wlan adapter. None of them show up.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
