Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTDNVOT (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTDNVOS (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:14:18 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:63241 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263936AbTDNVOM (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:14:12 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.5 'what to expect' document.
Date: Mon, 14 Apr 2003 23:25:53 +0200
User-Agent: KMail/1.5
References: <20030414193138.GA24870@suse.de> <200304142308.03553.fsdeveloper@yahoo.de> <20030414211311.GA11160@suse.de>
In-Reply-To: <20030414211311.GA11160@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304142325.47325.fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 23:13, Dave Jones wrote:
> On Mon, Apr 14, 2003 at 11:08:03PM +0200, Michael Buesch wrote:
>  > Will it be implemented in future to taint the kernel if CPU is
>  > overclocked?
>
> Theoretically possible on most CPUs, but it's not that simple.
> - Some CPUs don't encode the necessary bits to tell you their
>   current multiplier/FSB
> - Some CPUs don't encode the necessary info to tell you the speed
>   the CPU should be running at.

I know. That was exactly the reason for I asked. :)

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

