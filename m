Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269515AbUJLIPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269515AbUJLIPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269516AbUJLIPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:15:40 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:2215 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269515AbUJLIL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:11:58 -0400
Message-ID: <416B91C4.7050905@t-online.de>
Date: Tue, 12 Oct 2004 10:11:48 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "J.A. Magallon" <jamagallon@able.es>,
       Lista Mdk-Cooker <cooker@linux-mandrake.com>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev: what's up with old /dev ?
References: <1097446129l.5815l.0l@werewolf.able.es> <20041012001901.GA23831@kroah.com>
In-Reply-To: <20041012001901.GA23831@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: r3OL2oZDoeW9zsPPcR1MG6SsSW+AbyFWyd+KEfJyhMfDnDY-6G92EA
X-TOI-MSGID: 003c5f9e-f64d-43a6-9369-511a47b2c8d5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Oct 10, 2004 at 10:08:49PM +0000, J.A. Magallon wrote:
> 
>>Hi all...
>>
>>I have just remembered that udev mounts /dev as a tmpfs filesystem, _on top_
>>of the old /dev directory.
> 
> 
> Well, that's the way _your_ distro does it.  Mine has an empty /dev on
> the root filesystem, and the init scripts create a ramfs on top of /dev
> at boot time, which udev fills up.
> 

I don't like this "my distro is better than yours".
Any pointer to some code online?


Thanx very much

Harri
