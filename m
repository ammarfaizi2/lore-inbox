Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313403AbSDLG0w>; Fri, 12 Apr 2002 02:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313407AbSDLG0v>; Fri, 12 Apr 2002 02:26:51 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:12785 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S313403AbSDLG0u>; Fri, 12 Apr 2002 02:26:50 -0400
Date: Thu, 11 Apr 2002 23:26:47 -0700
From: Chris Wright <chris@wirex.com>
To: Timur Tabi <timur-linux@tabi.org>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I want to help with 2.5
Message-ID: <20020411232647.A4281@figure1.int.wirex.com>
Mail-Followup-To: Timur Tabi <timur-linux@tabi.org>,
	Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CB599A2.3010908@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Timur Tabi (timur-linux@tabi.org) wrote:
> Hi,
> 
> I would like to make a meaningful contribution to the 2.5 kernel, so I'm 
> wondering if anyone out there would like my help.  I would prefer to 
> work on a component where I could do the majority of the work, rather 
> than just help out with something massive.  Is there a particular piece 
> of hardware that needs a device driver that no one is working on?  Is 
> there some kernel enhancement that no one has gotten around too but 
> would be a good addition?  Please post or email your suggestion!  Thanks!

Have you looked at the kernel janitor project?  I know there are still
drivers that need to be moved away from virt_to_bus, for example.

http://kerneljanitor.org/

cheers,
-chris
