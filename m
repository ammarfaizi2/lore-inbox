Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWILU3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWILU3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWILU3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:29:22 -0400
Received: from smtp8.libero.it ([193.70.192.92]:62361 "EHLO smtp8.libero.it")
	by vger.kernel.org with ESMTP id S1030405AbWILU3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:29:21 -0400
Message-ID: <450718A6.4070301@libero.it>
Date: Tue, 12 Sep 2006 22:29:26 +0200
From: Marco <marco4ever@libero.it>
User-Agent: Mozilla Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.15 - 2.6.16 bad page with fglrx 8.28.8 on Radeon X300
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I cannot get back to a console after logging out from a Gnome/X session.
I just got a blank screen which does not response to any key press.
I have to turn off the power. This happens on a IBM Thinkpad T43p with 
ATI RADEON X300 and
with the non-free ATI driver fglrx 8.28.8 and kernels 2.6.15 / 2.6.16

I have found this patch (http://lkml.org/lkml/2005/12/11/26) for ATI 
driver fglrx 8.20.8-1 that
works very well with fglrx 8.20.8-1 driver.

Could you help me to make a patch for ATI driver fglrx 8.28.8 and 
kernels 2.6.15 / 2.6.16?

Thanks
Bye
Marco

