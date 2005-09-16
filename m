Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030579AbVIPDLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbVIPDLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 23:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVIPDLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 23:11:06 -0400
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:52380 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030579AbVIPDLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 23:11:05 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Date: Thu, 15 Sep 2005 22:10:58 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050916002036.GA6149@suse.de> <200509152136.08951.dtor_core@ameritech.net> <20050916024351.GC13486@vrfy.org>
In-Reply-To: <20050916024351.GC13486@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509152210.59276.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 21:43, Kay Sievers wrote:
> 
> Ah, I see. But the second model would work without any changes to
> existing software. :)
> 

Even for block? Besides, I don't think the result is "clean" even for
input devices. Interfaces would have to check whetehr the device is
input or interface device, etc, etc. I think it is time for change ;)

-- 
Dmitry
