Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbTLUTvz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTLUTvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:51:55 -0500
Received: from main.gmane.org ([80.91.224.249]:29364 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263904AbTLUTvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:51:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Backlund <tmb@iki.fi>
Subject: Re: PROBLEM: nForce2 keeps crashing during network activity
Date: Sun, 21 Dec 2003 21:51:52 +0200
Message-ID: <bs4tko$a2c$1@sea.gmane.org>
References: <200312211524.40325.cleanerx@au.hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Kübler wrote:

> Hi
> 
> My computer will freeze if I produce heavy network traffic. The crashes
> happen after an arbitrary time and seem not to be related to hardware
> defects. I tried the onboard nic and the rtl8139 which worked fine for me
> with my old mainboard. I've copied the same file with windowsXP and tried
> some other heavy network traffic just to see wheater it might be an
> hardware error but the system was stable. After I have started to import
> my home directory via NFS the crashes became more often. I will crash my
> system if I copy a big file via SMB.
> I had the problem with Mandrake 9.1 and now with 9.2 and even compiled my
> own kernel (mandrake source) with no effect.
> 
> Any suggestions?
> 

Boot with noapic or acpi=off

--
Regards

Thomas

