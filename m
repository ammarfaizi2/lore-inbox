Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUA3Row (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbUA3Row
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:44:52 -0500
Received: from mail.gmx.de ([213.165.64.20]:51150 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261974AbUA3RoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:44:07 -0500
X-Authenticated: #4512188
Message-ID: <401A97E0.4010704@gmx.de>
Date: Fri, 30 Jan 2004 18:44:00 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
References: <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de> <20040130172310.GB5265@kroah.com>
In-Reply-To: <20040130172310.GB5265@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>1.) Minor one: Nodes for Nvidia (I am using binary display modules 
>>1.0.5328) ar not created. I have to do it by hand each start-up (written 
> 
> Heh, and you expect me to be able to modify a binary driver to work with
> udev how?  :)

Oh OK, then I'll shut up. :-)

> What does:
> 	usbinfo -a -p /sys/class/usb/scanner0
> say?

Uhm, where to get this? I don't have it and I dunno which gentoo ebuild 
installs it. But I found a graphic app called "usbview". It basically 
gives the same infos as lsusb. Well, nevermind, I'l try what you said 
down. I'll try to get xsane goind with libusb.

Thanx,

Prakash
