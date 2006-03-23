Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbWCWDos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbWCWDos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWCWDos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:44:48 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:14755 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965141AbWCWDoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:44:46 -0500
Message-ID: <442219A4.3080801@garzik.org>
Date: Wed, 22 Mar 2006 22:44:36 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Mattia Dongili <malattia@linux.it>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Dual Core on Linux questions
References: <88056F38E9E48644A0F562A38C64FB6007A24C46@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6007A24C46@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>>From cpufreq perspective multiple things are possible in the way
> processor will support the multi-core frequency changing. and most of
> the things are handled at cpufreq inside kernel. I think there should be
> minima changes required in cpufreqd if any.
> Options:


4) we power down a core.

