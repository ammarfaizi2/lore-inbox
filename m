Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUE0HGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUE0HGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 03:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUE0HGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 03:06:39 -0400
Received: from grisu.bik-gmbh.de ([217.110.154.194]:18697 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP id S261661AbUE0HGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 03:06:32 -0400
Message-ID: <40B59367.9010609@bik-gmbh.de>
Date: Thu, 27 May 2004 09:06:15 +0200
From: Florian Hars <hars@bik-gmbh.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: de, de-de, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at usb:848
References: <40B4AF96.5090608@bik-gmbh.de> <20040526183113.GB25978@kroah.com>
In-Reply-To: <20040526183113.GB25978@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, May 26, 2004 at 04:54:14PM +0200, Florian Hars wrote:
>>Do you need anything else, besides the attached gunziped config.gz?
> What kernel version is this?
> 
> Can you enable CONFIG_USB_STORAGE_DEBUG and send the resulting log to
> the linux-usb-devel mailing list?

It is 2.6.6, and is the same piece of hardware as in
http://sourceforge.net/mailarchive/forum.php?thread_id=4794135&forum_id=5398
Which contains some logs from a related problem.

I'll try to reproduce this error later.

Yours, Florian
