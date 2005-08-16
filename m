Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVHPWB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVHPWB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVHPWB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:01:29 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:43145 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751104AbVHPWB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:01:28 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <greg@kroah.com>
Subject: udev-067 and 2.6.12?
Date: Tue, 16 Aug 2005 23:02:00 +0100
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508162302.00900.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried upgrading udev 053 to 067 on a 2.6.12 system and although the 
system booted, firmware_class failed to upload the firmware for my wireless 
card, prism54 was no longer auto loaded, etc. Even manually loading the 
driver didn't help.

Any reason why 067 wouldn't work with 2.6.12? Do you have to do something 
special with hotplug prior to upgrading?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
