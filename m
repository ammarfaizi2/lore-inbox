Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTDJClK (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 22:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTDJClK (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 22:41:10 -0400
Received: from adsl-b3-74-41.telepac.pt ([213.13.74.41]:17866 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S263732AbTDJClK (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 22:41:10 -0400
Message-ID: <3E94DCA1.5020106@vgertech.com>
Date: Thu, 10 Apr 2003 03:53:21 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Hermann Himmelbauer <dusty@violin.dyndns.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop
References: <200304091601.55821.dusty@violin.dyndns.org>
In-Reply-To: <200304091601.55821.dusty@violin.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Hermann Himmelbauer wrote:
> 
> Well - anyway, the kernel boots but right stops after:
> INIT: Entering runlevel:3
> 
> The next line is:
> INIT: open(/dev/console): Input/output error
> INIT: Id "2" respawning too fast: disabled for 5 minutes
> ...
> 
> That's it.

Maybe you striped too much and didn't include *any* console type 
(serial, vga or framebuffer)? :)

Regards,
Nuno Silva



