Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbVHTA3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbVHTA3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbVHTA3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:29:18 -0400
Received: from mail.dvmed.net ([216.237.124.58]:60126 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932582AbVHTA3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:29:17 -0400
Message-ID: <4306794F.4080402@pobox.com>
Date: Fri, 19 Aug 2005 20:29:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1: why is PHYLIB a user-visible option?
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <20050820002027.GJ3615@stusta.de>
In-Reply-To: <20050820002027.GJ3615@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Is there any reason why PHYLIB is a user-visible option?
> 
> As far as I understand it, PHYLIB and the MII PHY device drivers are an 
> internal library drivers should start to use roughly similar to MII.
> 
> But in this case, the options shouldn't be user-visible.

This code is still shaking out, so don't worry much about it right now.

	Jeff



