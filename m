Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUIXGPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUIXGPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbUIXGPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:15:13 -0400
Received: from mail.convergence.de ([212.227.36.84]:36757 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268487AbUIXGOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:14:25 -0400
Message-ID: <4153BB10.9010709@linuxtv.org>
Date: Fri, 24 Sep 2004 08:13:36 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: janitor@sternwelten.at
CC: akpm@digeo.com, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, nacc@us.ibm.com
Subject: Re: [linux-dvb-maintainer] [patch 01/20]  dvb/skystar2: replace schedule_timeout()
 	with msleep()
References: <E1CAapA-0003G3-4b@sputnik>
In-Reply-To: <E1CAapA-0003G3-4b@sputnik>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23.09.2004 23:08, janitor@sternwelten.at wrote:
> I would appreciate any comments from the janitor@sternweltens list.

dvb_sleep() is already gone in 2.6.9-rc2-mm2.

> Thanks,
> Nish

CU
Michael.
