Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbUCJXTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUCJXSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:18:14 -0500
Received: from imap.gmx.net ([213.165.64.20]:47807 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262885AbUCJXRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:17:03 -0500
X-Authenticated: #4512188
Message-ID: <404FA1F8.9060306@gmx.de>
Date: Thu, 11 Mar 2004 00:17:12 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
References: <20040303000957.GA11755@kroah.com> <404F1085.5080808@gmx.de> <20040310225114.GD24336@kroah.com>
In-Reply-To: <20040310225114.GD24336@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Mar 10, 2004 at 01:56:37PM +0100, Prakash K. Cheemplavam wrote:
>>I have a problem with udev and my ZIP drive (using latest mm based kernel):
>>
>>When I insert a zip the /dev for the partition doesn't get created (ie 
>>hdd4, fdisk shows it though).
> 
> Do you have udev creating all partitions for your hdd device?  That
> sounds like the option that you need to use.
> 

Nope, I don't have any special udev treatment for that device. Could you 
give me a clearer hint (docs?)? :-) I guess something about udev.rules?

Prakash
