Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbULHTXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbULHTXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbULHTWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:22:08 -0500
Received: from rutherford.zen.co.uk ([212.23.3.142]:8154 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S261327AbULHTV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:21:58 -0500
Message-ID: <41B75454.3060301@cantab.net>
Date: Wed, 08 Dec 2004 19:21:56 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix Dorner <felix_do@web.de>
CC: linux-kernel@vger.kernel.org, linux-laptop@mobilix.org
Subject: Re: internal card reader support
References: <41B74174.3080908@web.de>
In-Reply-To: <41B74174.3080908@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Dorner wrote:
> 
> 0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 
> 01)
> 0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 
> 01)
> 0000:02:04.2 System peripheral: Texas Instruments: Unknown device 8201 
> (rev 01)

This is a TI PCI1620.  You can get data sheets etc. from TI's website. 
Not sure how much good that will do you though as it appears to require 
firmware -- the 3rd function is a firmware loader interface.

David Vrabel
