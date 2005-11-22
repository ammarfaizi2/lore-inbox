Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVKVOIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVKVOIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVKVOIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:08:37 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:57260 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1751310AbVKVOIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:08:37 -0500
Date: Tue, 22 Nov 2005 15:08:33 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
Message-ID: <20051122140833.GA29822@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Folkert van Heusden <folkert@vanheusden.com>,
	linux-kernel@vger.kernel.org
References: <20051122130754.GL32512@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122130754.GL32512@vanheusden.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 02:07:54PM +0100, Folkert van Heusden wrote:
> My 2.6.14 system occasionally crashes; gives a kernel panic. Of course I
> would like to report it. Now the system locks up hard so I can't copy
> the stacktrace. The crash dump patches mentioned in oops-tracing.txt all
> don't work for 2.6.14 it seems. So: what should I do? Get my digicam and
> take a picture of the display?

Try the serial port- you can get a copy of the console on ttyS0.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
