Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUCJM4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUCJM4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:56:36 -0500
Received: from pop.gmx.de ([213.165.64.20]:5547 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262596AbUCJM4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:56:34 -0500
X-Authenticated: #4512188
Message-ID: <404F1085.5080808@gmx.de>
Date: Wed, 10 Mar 2004 13:56:37 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
References: <20040303000957.GA11755@kroah.com>
In-Reply-To: <20040303000957.GA11755@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with udev and my ZIP drive (using latest mm based kernel):

When I insert a zip the /dev for the partition doesn't get created (ie 
hdd4, fdisk shows it though).

What is the problem?

1) ATAPI Floppy lacks sysfs support?
2) I need to write some sort of rule?
3) Problem of udev?
4) something else?

Thanx,

Prakash
