Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSIJV6B>; Tue, 10 Sep 2002 17:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318168AbSIJV6A>; Tue, 10 Sep 2002 17:58:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8964 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318166AbSIJV57>;
	Tue, 10 Sep 2002 17:57:59 -0400
Message-ID: <3D7E6BE2.4080009@mandrakesoft.com>
Date: Tue, 10 Sep 2002 18:02:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Oliver Xymoron <oxymoron@waste.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, david-b@pacbell.net,
       mdharm-kernel@one-eyed-alien.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
References: <Pine.LNX.3.96.1020910173301.8675A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I've often wondered if it wouldn't be better to allow the user to provide
> a partition for oops use, where the kernel could write kmen and a few
> chosen other bit of information. Get all the oops output formatting code
> out of the kernel. Then the user could run tools like ksymoops against the
> oops after reboot, and a small utility could wrap and compress the oops,
> symbols table, config, etc, for future use by the user or developer. 

IOW, Linux Kernel Crash Dumps, something I've wanted for a long while.

http://lkcd.sourceforge.net/

