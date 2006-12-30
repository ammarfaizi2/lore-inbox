Return-Path: <linux-kernel-owner+w=401wt.eu-S1030298AbWL3TL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWL3TL0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 14:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWL3TL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 14:11:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1045 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030298AbWL3TLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 14:11:25 -0500
Date: Sat, 30 Dec 2006 20:11:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [OOPS] PPC NULL pointer dereference from cache_alloc_refill (ide?)
Message-ID: <20061230191128.GA20714@stusta.de>
References: <1f1b08da0612162246u36f1e265r596ff7afa9e988b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f1b08da0612162246u36f1e265r596ff7afa9e988b9@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 10:46:19PM -0800, john stultz wrote:

> Tried booting git from today (2.6.20-rc1+) on my PPC Mac Mini, and got
> the oops captured in the image attached.

Is this issue still presentin the latest -git?

> thanks
> -john


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

