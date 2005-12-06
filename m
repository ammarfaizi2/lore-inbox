Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVLFPDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVLFPDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbVLFPDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:03:23 -0500
Received: from rtr.ca ([64.26.128.89]:44964 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751681AbVLFPDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:03:23 -0500
Message-ID: <4395A838.5020800@rtr.ca>
Date: Tue, 06 Dec 2005 10:03:20 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Andy Isaacson <adi@hexapodia.org>, Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost> <20051206013759.GI1770@elf.ucw.cz> <20051206014720.GN22168@hexapodia.org> <43950A99.5040907@rtr.ca>
In-Reply-To: <43950A99.5040907@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>
> The FUJITSU MHV2100AH in my Dell i9300 gives 57.5 MB/sec with hdparm.

Whoah!  keyboard out of control and bad eyesight.  37.5, not 57.5 !!
