Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVCCCje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVCCCje (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVCCCe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:34:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:208 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261418AbVCCCcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:32:41 -0500
Message-ID: <42267737.4070702@pobox.com>
Date: Wed, 02 Mar 2005 21:32:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com>	<20050302162312.06e22e70.akpm@osdl.org>	<42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
In-Reply-To: <20050302165830.0a74b85c.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also note that part of the problem that motivates the even/odd thing 
is a tacit acknowledgement that people only _really_ test the official 
releases.

Which IMHO backs up my opinion that we simply need more frequent releases.

Part of this is a scalability problem.  Linux probably has more changes 
flowing into it than any other OS kernel on the planet.  We must deal 
with an ever-increasing number of changesets in a way that produces a 
usable kernel for our users.

	Jeff



