Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbUKRSmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbUKRSmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUKRSlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:41:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21660 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262850AbUKRSi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:38:59 -0500
Message-ID: <419CEC33.3010208@pobox.com>
Date: Thu, 18 Nov 2004 13:38:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [patch 2.6.10-rc2] oss: AC97 quirk facility
References: <20041117163016.A5351@tuxdriver.com> <20041117145644.005e54ff.akpm@osdl.org> <419CE98B.2090304@pobox.com> <Pine.LNX.4.53.0411181936050.8260@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411181936050.8260@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>Dumb question: why not just use the ALSA driver?
>>
>>Until we actually remove the OSS drivers, it's sorta silly to leave them
>>broken.
> 
> 
> It's just as silly to fix something we're removing anyway.

Until it's gone, the current users would prefer not-broken to broken.

	Jeff



