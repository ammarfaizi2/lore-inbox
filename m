Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbUCTKcc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbUCTKcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:32:31 -0500
Received: from imap.gmx.net ([213.165.64.20]:32931 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263332AbUCTKc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:32:28 -0500
X-Authenticated: #4512188
Message-ID: <405C1DB8.8000004@gmx.de>
Date: Sat, 20 Mar 2004 11:32:24 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc2, hotplug and ohci-hcd issue
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org> <405C1B14.6000206@gmx.de>
In-Reply-To: <405C1B14.6000206@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> it already started with 2.6.5-rc1: On shutdown/reboot when hotplug 
> service stops, it hangs. I found out that hotplug has trouble in 
> removing ohci-hcd module, ie, it doesn't seem to work. killall -9 rmmod 
> doesn't remove that process, neither. (Module unloading is in the kernel).
> 

Maybe I should add that I use current udev (on gentoo Linux).

cya,

Prakash
