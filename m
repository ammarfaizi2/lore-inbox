Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVLEPvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVLEPvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVLEPvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:51:43 -0500
Received: from rtr.ca ([64.26.128.89]:49873 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751376AbVLEPvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:51:42 -0500
Message-ID: <4394620C.1040700@rtr.ca>
Date: Mon, 05 Dec 2005 10:51:40 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Subodh Shrivastava <subodh.shrivastava@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc4
References: <8b12046a0512040612q45ee06ecv880ba775e3699561@mail.gmail.com>
In-Reply-To: <8b12046a0512040612q45ee06ecv880ba775e3699561@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subodh Shrivastava wrote:
> Hi,
> 
> ipw2100 in-kernel dirver associates with AP when using wpa_supplicant
> for WPA-PSK key management. But after few minutes it disassociates
> itself from the AP.

Upgrade to the latest wpa_supplicant package.
Something around 2.6.14 or so broke userland compatibility
with earlier wpa_supplicant code.

Cheers
