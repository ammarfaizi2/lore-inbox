Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVIKXY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVIKXY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 19:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVIKXY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 19:24:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:62873 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751069AbVIKXY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 19:24:57 -0400
Message-ID: <4324BCBB.90407@pobox.com>
Date: Sun, 11 Sep 2005 19:24:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: ak@suse.de, torvalds@osdl.org, Greg Edwards <edwardsg@sgi.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [2/3] Set compatibility flag for 4GB zone on IA64
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E72@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E72@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
> ia64 isn't all that homogeneous.  SGI systems stuff *all* memory
> into the DMA zone as their I/O devices have no 32-bit limits (just
> as well really as there is no memory below 4G on an Altix!).

SGI machines support random PCI cards, right?  If so, you cannot presume 
I/O devices have no 32-bit limits.

	Jeff


