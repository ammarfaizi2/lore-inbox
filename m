Return-Path: <linux-kernel-owner+w=401wt.eu-S1755271AbXABFow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbXABFow (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 00:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbXABFow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 00:44:52 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40996
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755271AbXABFow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 00:44:52 -0500
Date: Mon, 01 Jan 2007 21:44:50 -0800 (PST)
Message-Id: <20070101.214450.55508858.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: segher@kernel.crashing.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167714554.6165.56.camel@localhost.localdomain>
References: <1167713825.6165.54.camel@localhost.localdomain>
	<20070101.210108.41636312.davem@davemloft.net>
	<1167714554.6165.56.camel@localhost.localdomain>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Jan 2007 16:09:14 +1100

> Probably. The question now is that if we want to somewhat converge, what
> to do... either change sparc habits or change powerpc habits :-) I'll
> let that fight happen between you and paulus and watch while having a
> beer at LCA though :-)

compromise is always possible, especially over beer :)
