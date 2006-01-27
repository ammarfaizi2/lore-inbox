Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWA0Jel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWA0Jel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 04:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWA0Jel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 04:34:41 -0500
Received: from zux221-122-143.adsl.green.ch ([81.221.122.143]:33761 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S932444AbWA0Jek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 04:34:40 -0500
Date: Fri, 27 Jan 2006 10:17:58 +0100
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Documentation for /dev/tun
Message-ID: <20060127091758.GA6646@kestrel>
References: <20060126140402.GB13403@kestrel> <Pine.LNX.4.58.0601261543000.15286@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601261543000.15286@twin.jikos.cz>
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 03:44:41PM +0100, Jiri Kosina wrote:
> On Thu, 26 Jan 2006, Karel Kulhavy wrote:
> 
> > I have /dev/tun on my system and would like to read documentation about
> > it. Because I already know that /dev/ttyS0 has manual page under man
> > ttyS, I typed man tun No manual entry for tun also info tun No menu item
> > `tun' in node `(dir)Top'. I also tried "tun" and "/dev/tun" at Wikipedia
> > and they have nothing.
> 
> Documentation/networking/tuntap.txt
> drivers/net/tun.c is quite easy to read too.

Why is man ttyS present and man tun missing? Is there any rule which says
which devices should have manpage and which not?

CL<
> 
> -- 
> JiKos.
