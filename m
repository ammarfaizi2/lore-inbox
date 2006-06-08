Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWFHAPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWFHAPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWFHAPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:15:15 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:45979 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932507AbWFHAPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:15:14 -0400
Message-ID: <44876C17.6040709@acm.org>
Date: Wed, 07 Jun 2006 19:15:19 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
CC: Linus Torvalds <torvalds@osdl.org>, randy_d_dunlap@linux.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc6
References: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org> <Pine.LNX.4.64.0606070053530.10051@indiana.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.64.0606070053530.10051@indiana.corp.fedex.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
>
> On Mon, 5 Jun 2006, Linus Torvalds wrote:
>
>> ... a SATA resume fix that is reported to fix resume on at least a
>> couple of machines.
>
> Thank you. This works on my IBM X60s with Centrino Duo. Pure vanilla
> 2.6.17-rc6, no other patches necessary.
>
> Works with ata-piix, but not ahci.
Same for me on a thinkpad t60.  Works in compatability mode, not not in
AHCI.

-Corey
