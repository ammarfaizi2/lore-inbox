Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTLOCcM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 21:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTLOCcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 21:32:12 -0500
Received: from 101.24.177.216.inaddr.G4.NET ([216.177.24.101]:39831 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP id S263015AbTLOCcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 21:32:09 -0500
Date: Sun, 14 Dec 2003 21:31:49 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: How to send an IP packet from the kernel
In-Reply-To: <3FDD184A.80203@tait.co.nz>
Message-ID: <Pine.LNX.4.44.0312142130380.22128-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning, Dmytro,

On Mon, 15 Dec 2003, Dmytro Bablinyuk wrote:

> I have a dstaddr, srcaddr and the actual data(payload). I need to load 
> IP packet with data(payload) and send the packet out to the net through 
> eth0 .
> How do I do this from the kernel?

	Why not do it from userspace, with lots of available tools ( 
http://www.stearns.org/doc/pcap-apps.html , 
http://www.stearns.org/netreply )?
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Vi has two modes; the one in which it beeps and the one in
which it doesn't."
	-- Alan Cox
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

