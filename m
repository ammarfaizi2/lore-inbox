Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTDZQs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTDZQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:48:58 -0400
Received: from [81.80.245.157] ([81.80.245.157]:51079 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S261824AbTDZQs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:48:56 -0400
Date: Sat, 26 Apr 2003 19:00:19 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The IEEE-1394 saga continued... [ was: IEEE-1394 problem on init ]
Message-ID: <20030426170019.GE18917@vitel.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org> <20030423204258.GB10567@vitel.alcove-fr> <20030426082956.GB18917@vitel.alcove-fr> <20030426143445.GC2774@phunnypharm.org> <20030426161009.GC18917@vitel.alcove-fr> <20030426161233.GE2774@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426161233.GE2774@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 12:12:34PM -0400, Ben Collins wrote:

> > The FAQ on linux1394 site was indeed updated 2 days ago. I'm sorry
> > I didn't think to look there.
> 
> The rescan-scsi-bus.sh info has been there since sbp2 was introduced
> over a year ago.

The wording in that section suggested something changed three days ago.

> > This means that if you do
> > 	rmmod sbp2
> > 	modprobe sbp2
> > your SCSI device will be lost and you'll have to call 'rescan-scsi-bus'
> > by hand...
> 
> That's what /sbin/hotplug et al are for.

I don't think you understood my problem. Read again.

> in scsi/ieee1394, use 2.5.x.
> 
> Look, I'm not going to get pulled into this argument anymore. 

Neither will I.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
