Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266044AbUALC0W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUALC0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:26:22 -0500
Received: from mail503.nifty.com ([202.248.37.211]:12674 "EHLO
	mail503.nifty.com") by vger.kernel.org with ESMTP id S266044AbUALC0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:26:21 -0500
Subject: Re: [PATCH 2.6.0] Cirrus PD6729 PCI-to-PCMCIA Bridge support
	for2.6.x kernel
From: Komuro <komujun@nifty.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <000f01c3d8a3$d23eb660$6c24dbdc@HQA02330>
References: <1073819401.2329.7.camel@localhost.localdomain>
	 <1073821972.4431.12.camel@laptop.fenrus.com>
	 <000f01c3d8a3$d23eb660$6c24dbdc@HQA02330>
Content-Type: text/plain
Organization: 
Message-Id: <1073874361.2015.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Jan 2004 11:26:01 +0900
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Arjan


>> I made a Cirrus PD6729 PCI-to-PCMCIA Bridge for 2.6.x kernel
>> Please see the following patch. ( sorry for big patch)
>
>one question though; is it worth trying to share some code with the 
>i82092 driver ? (I don't have the specs with me but it looks like the
>Cirrus is not THAT different in most respects so maybe some code can
>be shared)

(1)I think if the driver name is i82092, people may think it supports
82092 chipset only.

(2)I don't have 82092 chipset and its datasheet.
I can't test the i82092 driver.

The pd6729 driver works fine with my CL PD6729 chipset.

Best Regards
Komuro


