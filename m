Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUGDQq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUGDQq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUGDQq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:46:57 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36281 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265200AbUGDQqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:46:55 -0400
Date: Sun, 4 Jul 2004 18:46:54 +0200
From: bert hubert <ahu@ds9a.nl>
To: Hermann Gottschalk <hg@ostc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Network behaviour
Message-ID: <20040704164654.GA18688@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Hermann Gottschalk <hg@ostc.de>, linux-kernel@vger.kernel.org
References: <20040702153028.GD15170@ostc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702153028.GD15170@ostc.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 05:30:28PM +0200, Hermann Gottschalk wrote:

> This happend for a long time until there was a kernel patch from
> 2.4.21-215 to 2.4.21-266. Since it is installed this error doesn't
> appear anymore.

If it ever happens again, supply the output of ifconfig after it happens,
and dmesg, and lspci -v -v -v. Sure looks like a weird error though,
probably not related to your network interfaces. 

'Protocol not available' is a weird one.

Perhaps something with modules?

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
