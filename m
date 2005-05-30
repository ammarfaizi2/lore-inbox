Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVE3Nff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVE3Nff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 09:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVE3Nfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 09:35:34 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:47118 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261549AbVE3Nef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 09:34:35 -0400
Date: Mon, 30 May 2005 15:38:26 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050530133826.GC32046@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530093420.GB15347@hout.vanvergehaald.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 11:34:20AM +0200, Toon van der Pas wrote:
> On Mon, May 30, 2005 at 05:19:43PM +0800, Lincoln Dale (ltd) wrote:
> > > But what you claim is simply impossible.
> > 
> > wrong. again.
> > 
> > look up the man page for udev(8), pay particular attention to the part
> > that can tie devname into device serial number.
> > take note of the example shown under 'serial'.
> 
> These were my thoughts too.
> But I just checked the entries in my sysfs tree for my CDRW drive,
> and there is no serial number available...

 Wild thouht - you can attach a camera pointing to device and use udev
callout script, which will grab a picture by v4l and check color.
 It *is* possible in Linux.

-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated. -- Alex Yuriev

