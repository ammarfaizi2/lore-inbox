Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVDATXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVDATXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 14:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVDATXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 14:23:43 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:1737 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S262861AbVDATWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 14:22:48 -0500
Message-ID: <424D9FCE.6020200@pin.if.uz.zgora.pl>
Date: Fri, 01 Apr 2005 21:23:58 +0200
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Michael Thonke <tk-shockwave@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-Express not working/unuseable on Intel 925XE Chipset since
 2.6.12-rc1[mm1-4]
References: <424D44F0.6090707@web.de> <424D5E2E.8040207@pin.if.uz.zgora.pl> <424D71DE.5060703@web.de> <424D91B5.50404@pin.if.uz.zgora.pl> <424D9A9C.2070705@web.de>
In-Reply-To: <424D9A9C.2070705@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke napisał(a):
> Hello Jacek,
> 
> I finially got it working :-) my PCI-Express devices working now...
> I grabbed the last bk-snapshot from kernel.org 2.6.12-rc1-bk3 and et volia
> everything except the Marvell Yokon PCI-E device working.
> I hope Andrew will look into the mm-line to find the bug?
> 

I've got Marvell Yukon 88E8053 GigE and it works fine with fixed (by 
myself :]) driver from syskonnect. If you wont I may send it to you!

	Jacek
