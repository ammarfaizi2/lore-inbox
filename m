Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753511AbWKMR6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbWKMR6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbWKMR6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:58:15 -0500
Received: from rtr.ca ([64.26.128.89]:29711 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1753511AbWKMR6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:58:13 -0500
Message-ID: <4558B232.8080600@rtr.ca>
Date: Mon, 13 Nov 2006 12:58:10 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>,
       John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de> <455893E5.4010001@garzik.org>
In-Reply-To: <455893E5.4010001@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andi Kleen wrote:
>
>> How does it shorten its life?
> 
> Parks your hard drive heads many thousands of times more often than it 
> does without the aggressive PM features.

Spinning-down would definitely shorten the drive lifespan.  Does it do that?

Parking heads is more like just doing some extra (long) seeks.
Is this documented somewhere as being a life-shortening action?

Cheers
