Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTK3KUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 05:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTK3KUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 05:20:55 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:14486 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263666AbTK3KUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 05:20:54 -0500
Date: Sun, 30 Nov 2003 11:20:53 +0100
From: bert hubert <ahu@ds9a.nl>
To: Rainer Hochreiter <rainer@hochreiter.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip routing
Message-ID: <20031130102053.GA10380@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Rainer Hochreiter <rainer@hochreiter.at>,
	linux-kernel@vger.kernel.org
References: <1070180482.1852.25.camel@freddie.hochreiter.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070180482.1852.25.camel@freddie.hochreiter.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Nov 30, 2003 at 09:24:01AM +0100, Rainer Hochreiter wrote:

>      eth0=10.1.0.1/16 +-----+ eth1=10.2.0.1/16
>                    .--|Tux1 |--.
>                    |  +-----+  |
> eth1=10.1.0.254/16 |           | eth1=10.2.0.254/16

I haven't read all of your problem, but you might want to look policy
routing on http://lartc.org/howto/lartc.rpdb.html


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
