Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264042AbUD0Nth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbUD0Nth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 09:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUD0Nth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 09:49:37 -0400
Received: from dsl081-101-153.den1.dsl.speakeasy.net ([64.81.101.153]:47816
	"EHLO mail.chen-becker.org") by vger.kernel.org with ESMTP
	id S264042AbUD0Ntf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 09:49:35 -0400
Message-ID: <408E64EB.6080204@chen-becker.org>
Date: Tue, 27 Apr 2004 07:49:31 -0600
From: Derek Chen-Becker <derek@chen-becker.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kim Holviala <kim@holviala.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Troubleshooting PS/2 mouse in 2.6.5
References: <408D4CB4.4070901@chen-becker.org> <200404270849.23397.kim@holviala.com>
In-Reply-To: <200404270849.23397.kim@holviala.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala wrote:
> On Monday 26 April 2004 20:53, Derek Chen-Becker wrote:
> 
> 
>>     I'm upgrading my workstation from 2.4.22 to 2.6.5 and everything is
>>working great except for /dev/input/mice: it doesn't appear to be
>>producing anything, even if I cat it. I've checked and both dmesg and
>>/proc/bus/input/devices show the mouse handler loaded and show the mouse
>>as recognized.
> 
> 
> What do the system logs say? I suggest you build psmouse into a module so that 
> you can modprobe/rmmod it to test stuff without rebooting.
> 

They appeared to indicate that it had loaded. I'll save the contents of 
dmesg and /proc/bus/input/devices and post it.

Thanks,

Derek

-- 
+---------------------------------------------------------------+
| Derek Chen-Becker                                             |
| derek@chen-becker.org                                         |
| http://chen-becker.org                                        |
|                                                               |
| PGP key available on request or from public key servers       |
| ID: 21A7FB53                                                  |
| Fngrprnt: 209A 77CA A4F9 E716 E20C  6348 B657 77EC 21A7 FB53  |
+---------------------------------------------------------------+
