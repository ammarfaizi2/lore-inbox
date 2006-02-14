Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWBNSlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWBNSlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWBNSln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:41:43 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:41486 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1030376AbWBNSln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:41:43 -0500
Date: Tue, 14 Feb 2006 19:41:42 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matthias Andree <matthias.andree@gmx.de>, Nix <nix@esperi.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214184142.GA51709@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Matthias Andree <matthias.andree@gmx.de>, Nix <nix@esperi.org.uk>,
	linux-kernel@vger.kernel.org
References: <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix> <20060214092207.GA32405@merlin.emma.line.org> <Pine.LNX.4.61.0602141908360.32490@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602141908360.32490@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 07:09:19PM +0100, Jan Engelhardt wrote:
> My IDE one is neither nowhere in /sys/class. (Maybe I did not try looking 
> hard enough, though.)

Why care, official policy is that you should do device discovery
through udevinfo and not touch sysfs.

  OG.

