Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270781AbTGNUXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270783AbTGNUUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:20:41 -0400
Received: from 217-124-18-51.dialup.nuria.telefonica-data.net ([217.124.18.51]:4502
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S270823AbTGNURc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:17:32 -0400
Date: Mon, 14 Jul 2003 22:32:19 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: requirements for installing a 2.6.0-test kernel....
Message-ID: <20030714203219.GA4726@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200307141659.05451.m.watts@eris.qinetiq.com> <20030714163749.GC2684@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714163749.GC2684@wind.cocodriloo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 14 July 2003, at 18:37:49 +0200,
Antonio Vargas wrote:

> Mark, I'm also interested on this, and also willing to install
> a recent distro on purpose. Would you mind if we shared install experiences?
> 
I have been doing some real (workstation-class) work with Debian Sid and
2.5.x kernels with great success for a while now. The only problem I had
so far was starting at 2.5.74, when DM/LVM2 ioctl version changed, and
my current Sid device mapper tools are not still up to date (and
compilation of LVM2.0.0 from sources fails).

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.5.73)
