Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWJXQ67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWJXQ67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWJXQ66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:58:58 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:18578 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030320AbWJXQ66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:58:58 -0400
Message-ID: <453E4654.1030809@drzeus.cx>
Date: Tue, 24 Oct 2006 18:59:00 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Timo Teras <timo.teras@solidboot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: MMC: When rescanning cards check existing cards after mmc_setup()
References: <20061016090609.GB17596@mail.solidboot.com> <453B4005.8080501@drzeus.cx> <20061024101458.GA17024@mail.solidboot.com>
In-Reply-To: <20061024101458.GA17024@mail.solidboot.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Teras wrote:
> On Sun, Oct 22, 2006 at 11:55:17AM +0200, Pierre Ossman wrote:
>   
>> If we check cards on both sides of mmc_setup(), then we should be covered.
>>     
>
> Should I update my patch to do this already? Or is the code fine as is?
>
>   

Please include it in your revised patch.

>> Also, please add some comments about why we do this. Otherwise it will
>> run the risk of getting removed in the future.
>>     
>
> Will do.
>
> I'll send updated patch later on.
>
>   

Looking forward to it. :)

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

