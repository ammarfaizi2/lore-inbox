Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTLEUeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTLEUeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:34:50 -0500
Received: from pop.gmx.net ([213.165.64.20]:57740 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264478AbTLEUet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:34:49 -0500
X-Authenticated: #4512188
Message-ID: <3FD0EBE6.9080003@gmx.de>
Date: Fri, 05 Dec 2003 21:34:46 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: cheuche+lkml@free.fr
CC: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com> <20031205201812.GA10538@localnet>
In-Reply-To: <20031205201812.GA10538@localnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> through easily. I first thought the box freezed but I realized the
> software cursor was blinking *very* slowly. In fact 1 second for the
> kernel took about 12 seconds. Stopping the IO load on ide and
> everything seems back to normal.

Hmm, interesting observation. This makes me remeber something: When my 
machine freezes doing hdparm, the cursor still blinks, but I can't do 
anything anymore. Maybe a connection to your observation? I haven't 
treid to run the NMI watchdog, as you guys haven't had success with it yet.

Prakash


