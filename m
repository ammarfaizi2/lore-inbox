Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVKDS7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVKDS7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVKDS7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:59:25 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:28907 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S1750822AbVKDS7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:59:24 -0500
Date: Fri, 4 Nov 2005 11:09:07 -0800 (PST)
From: Eric Sandall <eric@sandall.us>
X-X-Sender: sandalle@cerberus
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net
Subject: Re: Problems with 2.6.13.4 and sws2 2.2-rc6
In-Reply-To: <1131054277.5497.1.camel@localhost>
Message-ID: <Pine.LNX.4.63.0511041108260.2180@cerberus>
References: <Pine.LNX.4.63.0511021848420.5265@cerberus> <1131054277.5497.1.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 4 Nov 2005, Nigel Cunningham wrote:
> Hi Eric.
> On Thu, 2005-11-03 at 13:56, Eric Sandall wrote:
>> I cannot seem to hibernate this machine (Dell Inspiron 5100) after
>> 2.6.12. When I do try, I'm told to report what's in dmesg.log
>> (attached). I've also included the hibernate log (hibernate.log) and
>> the output of `lspci -vv` (lspci.log).
>>
>> Let me know if you need more information or want me to test any
>> patches.
>>
>> Thank you,
>
> Please post to the Suspend2 lists (found via suspend2.net). If you
> download rc7 or (preferably) rc8, this will be fixed.
>
> Regards,
>
> Nigel

Updating to rc7 (I'm still using the 2.6.13 kernels for now) fixed it,
thank you. :)

- -sandalle

- --
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDa7HVHXt9dKjv3WERAlyDAJ0bc4sQoT1UHEwCjt05ItTTf5fIqACffOBH
MJ3eg1/1nEUx6cwYtDZrWNM=
=prG6
-----END PGP SIGNATURE-----
