Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTLOJzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 04:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTLOJzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 04:55:49 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:46982 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263452AbTLOJzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 04:55:48 -0500
Date: Mon, 15 Dec 2003 10:55:47 +0100
From: bert hubert <ahu@ds9a.nl>
To: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filesystem bug?
Message-ID: <20031215095547.GA2279@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <3FDD7DFD.7020306@labs.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDD7DFD.7020306@labs.fujitsu.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 06:25:17PM +0900, Tsuchiya Yoshihiro wrote:


> I use RedHat9 which kernel is 2.4.20-8 and I also tried
> 2.4.20-19.9(redhat kernel patch rpm).
> 
> I want to know whether it is a redhat kernel problem or a generic
> Ext problem and on which version it is fixed.

Red Hat patch their kernel so heavily it is hard to tell if this applies to
stock 2.4 as well, I suggest you compile your own version and compare. If
you want to be really helpful, try 2.6 too :-)

Wonderful testing by the way, thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
