Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264094AbUD0OFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbUD0OFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUD0OFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:05:08 -0400
Received: from postmanpat.isu.mmu.ac.uk ([149.170.192.66]:32158 "EHLO
	postmanpat.isu.mmu.ac.uk") by vger.kernel.org with ESMTP
	id S264094AbUD0OFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:05:01 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: Re: Anyone got aic7xxx working with 2.4.26?
Date: Tue, 27 Apr 2004 15:05:37 +0100
User-Agent: KMail/1.6
References: <200404261532.37860.dj@david-web.co.uk> <20040427132114.GD10264@logos.cnet>
In-Reply-To: <20040427132114.GD10264@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404271505.38166.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 Apr 2004 14:21, Marcelo Tosatti wrote:
>
> Hi David,
>
> Can you post save the boot messages and post? 

I'm not sure - I'll try to find out.

> Which 2.4/2.6 works on this box?

2.4.24 and earlier works, but I haven't tried 2.4.25. I haven't found a 2.6 
that works but I haven't tried anything older than 2.6.5.

>
> What are the boot messages with 2.6.5 and newer?

I'm afraid I don't have these, but will try to get them. There are no errors 
or anything out of the ordinary, it just hangs when it gets to finding the 
SCSI devices.

I've got a bug report (http://bugzilla.kernel.org/show_bug.cgi?id=2517) which 
has my dmesg from 2.4.24 and I've noted in it where 2.4.26 hangs.
2.6.5 (and newer) hangs in exactly the same place with either the old or new 
driver, again with no errors.

I know this is isn't a lot to go on, but it's difficult to play with it as its 
in production. Let me know what you'd like me to do next and I'll try to do 
it. Shall I compile in the driver's debugging stuff?

Thanks,
David.

-- 
David Johnson
http://www.david-web.co.uk/
