Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbUKORIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUKORIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUKORGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:06:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62910 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261648AbUKORGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:06:40 -0500
Message-ID: <4198E20E.5070305@pobox.com>
Date: Mon, 15 Nov 2004 12:06:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "O.Sezer" <sezeroz@ttnet.net.tr>
CC: linux-kernel@vger.kernel.org, John Linville <linville@redhat.com>
Subject: Re: [netdrvr] netdev-2.4 queue updated
References: <4198C64A.6050900@ttnet.net.tr>
In-Reply-To: <4198C64A.6050900@ttnet.net.tr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O.Sezer wrote:
>> John W. Linville:
>>   o 3c59x: resync with 2.6
>>
> 
> Any specific reason that the following two are not included ?
> 
> 3c59x: reload EEPROM values at rmmod for needy cards:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109726032213947&w=2
> 
> 3c59x: remove EEPROM_RESET for 3c905 :
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109802672909516&w=2

Ask John Linville...  IIRC they caused problems?

	Jeff



