Return-Path: <linux-kernel-owner+w=401wt.eu-S1751021AbWLQTzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWLQTzI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 14:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWLQTzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 14:55:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:46353 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbWLQTzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 14:55:07 -0500
Subject: Re: [OOPS] PPC NULL pointer dereference from cache_alloc_refill
	(ide?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1f1b08da0612162246u36f1e265r596ff7afa9e988b9@mail.gmail.com>
References: <1f1b08da0612162246u36f1e265r596ff7afa9e988b9@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 06:54:37 +1100
Message-Id: <1166385277.31351.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-16 at 22:46 -0800, john stultz wrote:
> Tried booting git from today (2.6.20-rc1+) on my PPC Mac Mini, and got
> the oops captured in the image attached.

No idea at this point, I'll have to dig... maybe something changed in
the IDE code and ide pmac wasn't updated..

Ben.


