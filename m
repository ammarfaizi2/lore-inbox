Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWBFXuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWBFXuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWBFXuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:50:35 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11171
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964809AbWBFXue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:50:34 -0500
Date: Mon, 06 Feb 2006 15:50:28 -0800 (PST)
Message-Id: <20060206.155028.115708927.davem@davemloft.net>
To: david.carlton@sun.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: network delays, mysterious push packets
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <yf2k6c8ru3x.fsf@kealia.sfbay.sun.com>
References: <yf2k6c8ru3x.fsf@kealia.sfbay.sun.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Carlton <david.carlton@sun.com>
Date: Mon, 06 Feb 2006 14:38:10 -0800

> I'm working on an application that we're trying to switch from a 2.4
> kernel to a 2.6 kernel.  (I believe we're using 2.6.9.)  One part of
> the program periodically sends out chunks of data (whose size is just
> over 1MB) via tcp.

Please reproduce with something more current and report to the correct
mailing list (netdev@vger.kernel.org).

Thanks.
