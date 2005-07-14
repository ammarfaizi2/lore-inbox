Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbVGNJXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbVGNJXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVGNJXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:23:17 -0400
Received: from rimuhosting.com ([69.90.33.248]:59600 "EHLO rimuhosting.com")
	by vger.kernel.org with ESMTP id S262994AbVGNJU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:20:59 -0400
Message-ID: <42D62E66.8070709@rimuhosting.com>
Date: Thu, 14 Jul 2005 21:20:38 +1200
From: Peter <peter.spamcatcher@rimuhosting.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: unregister_netdevice: waiting for tap24 to become
 free
References: <20050709110143.D59181E9EA4@zion.home.lan> <200507120020.52418.blaisorblade@yahoo.it> <42D2F22C.3060102@rimuhosting.com> <200507120047.33064.blaisorblade@yahoo.it>
In-Reply-To: <200507120047.33064.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried 2.6.12.2 with skas-V8.2.  The server (otherwise reliable), 
had a kernel crash (which I was unable to capture) within a couple of 
hours of boot up.

Regards, Peter

Blaisorblade wrote:
> On Tuesday 12 July 2005 00:26, Peter wrote:
> 
>>Nothing in the logs prior to the first error message.
>>
>>I've hit this before at different times on other servers.  If there are
>>some commands I can run to gather more diagnostics on the problem,
>>please let me know and I'll capture more information next time.
>>
>>I see the error was reported with older 2.6 kernels and a patch was
>>floating around.  I'm not sure if that is integrated into the current
>>2.6.11 kernel.
> 
> The patch named there has been integrated, verifyable at 
> http://linux.bkbits.net:8080/linux-2.6/cset@4129735fMSVl0_RA4uNcNBWHFjT-zw
> 
> However this time the bug is probably due to something entirely different, the 
> message is not very specific.
> 
> Tried 2.6.12? SKAS has been already updated (plus there's an important update 
> for SKAS, from -V8 to -V8.2).
> 
>>http://www.google.com/search?q=unregister_netdevice%3A+waiting
>>
>>Regards, Peter
> 
> 
