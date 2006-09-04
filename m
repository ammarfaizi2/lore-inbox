Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWIDMEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWIDMEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWIDMEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:04:51 -0400
Received: from netprotector.fi ([81.209.6.194]:14757 "EHLO mail.osp.fi")
	by vger.kernel.org with ESMTP id S964847AbWIDMEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:04:50 -0400
Message-ID: <44FC165D.5000808@osp.fi>
Date: Mon, 04 Sep 2006 15:04:45 +0300
From: Johnny Strom <johnny.strom@osp.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060803 Debian/1.7.8-1sarge7.2.1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch to make VIA sata board bootable again.
References: <44F7EC15.8040800@osp.fi> <20060901014745.750e69d1.akpm@osdl.org> <44F81013.4030904@osp.fi> <20060901155510.GA28345@tuatara.stupidest.org>
In-Reply-To: <20060901155510.GA28345@tuatara.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Fri, Sep 01, 2006 at 01:48:51PM +0300, Johnny Strom wrote:
> 
> 
>>No it is the same problem with 2.6.18-rc5.
> 
> 
> Did either the patches from Daniel Drake or Sergio Monteiro Basto
> help?
> 
> 


hello

I have now tested the patch found here:

http://lkml.org/lkml/2006/9/3/148

And that patchs works fine, I can now boot the system.


I have also tested this patch pci-quirk_via_irq-behaviour-change.patch
and it works fine as well, I can boot the system again.

It is kernel version 2.6.17.11 that I have tested the patches on.

So any of those two patches makes my system boot again.


Johnny




-- 
VGER BF report: H 0
