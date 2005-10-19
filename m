Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVJSC3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVJSC3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 22:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVJSC3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 22:29:00 -0400
Received: from mail.dvmed.net ([216.237.124.58]:27293 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932475AbVJSC27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 22:28:59 -0400
Message-ID: <4355AF67.8010604@pobox.com>
Date: Tue, 18 Oct 2005 22:28:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, shemminger@osdl.org,
       mlindner@syskonnect.de, rroesler@syskonnect.de
Subject: Re: [patch 2.6.14-rc4 0/3] sk98lin: neuter and prepare for removal
References: <10182005213059.12304@bilbo.tuxdriver.com>
In-Reply-To: <10182005213059.12304@bilbo.tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> These patches take steps towards removing sk98lin from the upstream
> kernel.
> 
> 	-- Remove sk98lin's MODULE_DEVICE_TABLE to avoid
> 	confusing userland tools about which driver to load;
> 
> 	-- Mark sk98lin as Obsolete in the MAINTAINERS file; and,
> 
> 	-- Add sk98lin to the feature-removal-schedule.txt file in the
> 	Documentation directory.
> 
> I accept the possibility that I may be jumping the gun on this.
> However, I think it is worth opening this discussion.

I'll let Stephen make the call on this one (as he did...).

	Jeff



