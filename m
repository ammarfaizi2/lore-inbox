Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSJOQdY>; Tue, 15 Oct 2002 12:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264750AbSJOQdY>; Tue, 15 Oct 2002 12:33:24 -0400
Received: from tux.creighton.edu ([147.134.5.192]:26028 "EHLO tux.obix.com")
	by vger.kernel.org with ESMTP id <S264749AbSJOQdX>;
	Tue, 15 Oct 2002 12:33:23 -0400
Message-ID: <3DAC44B4.60607@tux.obix.com>
Date: Tue, 15 Oct 2002 11:39:16 -0500
From: Phil Brutsche <phil@tux.obix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Anthony Martinez <i_am_pi_@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD PCNet adapter
References: <F206ccSN00ktmzmVBCO00002a2e@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Martinez wrote:
> Hello
> Are there modem drivers available for an AMD PCNet adapter, chip AM79C978XC, 
> or is this even the right place to ask?
> 
> This card has both ethernet and modem ports, and works with the windoze 
> drivers.

Those aren't modem ports; those are POTS ports for HomePNA 
(http://homepna.org/) networking.

It will work fine using the RJ45 connector; chances are the PhoneNet 
networking will work fine if you just *try* it.


Phil

