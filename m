Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVBRLZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVBRLZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 06:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVBRLZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 06:25:08 -0500
Received: from ns.suse.de ([195.135.220.2]:42881 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261332AbVBRLZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 06:25:01 -0500
Message-ID: <4215D03F.7070206@suse.de>
Date: Fri, 18 Feb 2005 12:23:43 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       dtor_core@ameritech.net, Bernard Blackham <bernard@blackham.com.au>
Subject: Re: Swsusp, resume and kernel versions
References: <200502162346.26143.dtor_core@ameritech.net>	 <1108617332.4471.33.camel@desktop.cunningham.myip.net.au>	 <200502170038.30033.dtor_core@ameritech.net>	 <1108627778.4471.54.camel@desktop.cunningham.myip.net.au>	 <421506FC.3060909@suse.de> <1108722865.4077.8.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1108722865.4077.8.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi Stefan.
> 
> For Suspend2, we also put a device id in the space, so there's only room
> for one character, which is a lower or upper case Z. (We also validate
> the device ID, so a random Z won't cause an oops).
> 
> Thanks for the code. With your/Suse's permission, I'll ask Bernard
> (cc'd) to include the script in the docs somewhere with the appropriate
> credit.

i have consulted our license guy and the original author of
/etc/init.d/boot.swap and am glad to say that it is GPL'd ;-)

Have fun,

  Stefan

-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX, Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
