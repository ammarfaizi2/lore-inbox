Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVCXIKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVCXIKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVCXIKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:10:08 -0500
Received: from alephnull.demon.nl ([212.238.201.82]:2436 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S262428AbVCXIKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:10:05 -0500
Date: Thu, 24 Mar 2005 09:10:03 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Ben Greear <greearb@candelatech.com>
Cc: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
Message-ID: <20050324081003.GA23453@xi.wantstofly.org>
References: <42421FF2.7050501@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42421FF2.7050501@candelatech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 06:03:30PM -0800, Ben Greear wrote:

> I have two 4-port e1000 NICs in the system, on a riser card.

How is the riser card wired?  F.e. does it have a single edge
connector, and provides two PCI slots, or does it have a tiny
additional edge connector that routes REQ#/GNT#/INTx from a
nearby PCI slot, etc.?


--L
