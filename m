Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVA1OJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVA1OJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVA1OJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:09:55 -0500
Received: from 8f.7b.d1c4.cidr.airmail.net ([209.196.123.143]:41990 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261388AbVA1OFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:05:38 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 28 Jan 2005 08:04:26 -0600
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>,
       David Brownell <david-b@pacbell.net>,
       jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
Message-ID: <20050128140426.GF2490@artsapartment.org>
References: <200501232251.42394.david-b@pacbell.net> <priv$1106815487.koan@shadow.banki.hu> <200501271128.48411.david-b@pacbell.net> <200501271511.58086.david-b@pacbell.net> <20050127154150.360f95e2.davem@davemloft.net> <41F99656.5040304@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F99656.5040304@trash.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 02:33:10AM +0100, Patrick McHardy wrote:
> Here is the fix for everyone. Please report back if it doesn't
> solve the problem. Thanks.
> 
> [ ... snip ... ]

Success!!!

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
