Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTK3KXx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 05:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTK3KXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 05:23:53 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:15510 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263667AbTK3KXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 05:23:52 -0500
Date: Sun, 30 Nov 2003 11:23:51 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Message-ID: <20031130102351.GB10380@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
References: <20031130071757.GA9835@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130071757.GA9835@node1.opengeometry.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 02:17:57AM -0500, William Park wrote:
> Does anyone have modem working in 2.6.0-test11?
> 
> I have external modem connected to /dev/ttyS0 (COM1).  Kernel
> 2.6.0-test11 give me

Double check your .config and attach it if in doubt.

Something like grep SERIAL .config might be enlightning.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
