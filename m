Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbRGSRd2>; Thu, 19 Jul 2001 13:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbRGSRdI>; Thu, 19 Jul 2001 13:33:08 -0400
Received: from ns.suse.de ([213.95.15.193]:16145 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265478AbRGSRc7>;
	Thu, 19 Jul 2001 13:32:59 -0400
To: Cornel Ciocirlan <ctrl@rdsnet.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request for comments
In-Reply-To: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Jul 2001 19:33:02 +0200
In-Reply-To: Cornel Ciocirlan's message of "19 Jul 2001 18:06:36 +0200"
Message-ID: <oup4rs8kenl.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Cornel Ciocirlan <ctrl@rdsnet.ro> writes:

> Hi, 
> 
> I was thinking of starting a project to implement a Cisco-like
> "NetFlow" architecture for Linux. This would be relevant for edge routers
> and/or network monitoring devices.  

Linux 2.1+ already has such a cache in form of the rtcache since several
years.

-Andi

