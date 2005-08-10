Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVHJHyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVHJHyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVHJHyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:54:40 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:62081 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S965040AbVHJHyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:54:40 -0400
Date: Wed, 10 Aug 2005 10:54:36 +0300
To: Patrick McHardy <kaber@trash.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net/ipv4 debug cleanup, kernel 2.6.13-rc5
Message-ID: <20050810075436.GW27323@jolt.modeemi.cs.tut.fi>
References: <20050807123145.GJ27323@jolt.modeemi.cs.tut.fi> <42F953CE.305@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <42F953CE.305@trash.net>
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 03:09:34AM +0200, Patrick McHardy wrote:
> These macros always looked a bit ugly to me, with your cleanup there
> isn't a single spot left where we require them to accept code as
> argument, so how about we change them to pure printk wrappers?

Sounds like a good idea.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
