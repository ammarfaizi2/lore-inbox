Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbULPGdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbULPGdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 01:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbULPGdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 01:33:41 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:43530 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262609AbULPGdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 01:33:40 -0500
Date: Thu, 16 Dec 2004 07:16:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: David Jacoby <dj@outpost24.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
Message-ID: <20041216061641.GJ17946@alpha.home.local>
References: <41BFF931.6030205@outpost24.com> <20041215.180839.93043538.yoshfuji@linux-ipv6.org> <41C024B0.4010009@outpost24.com> <200412151254.37612@WOLK> <41C0268B.2030708@outpost24.com> <20041215114017.3a735aa8.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215114017.3a735aa8.davem@davemloft.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 11:40:17AM -0800, David S. Miller wrote:
 
> There is no way that patch can change SSH behavior, you changed
> something else when you updated your kernel.

He changed from 2.4.24 to 2.6.9, quite a few megabytes of patch indeed :-)

Willy

