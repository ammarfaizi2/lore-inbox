Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267243AbUHOX3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267243AbUHOX3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUHOX3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:29:04 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:41396 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267243AbUHOX3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:29:01 -0400
Message-ID: <411FF170.9070700@rtr.ca>
Date: Sun, 15 Aug 2004 19:27:44 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com>
In-Reply-To: <411FD744.2090308@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hdparm works for some SCSI devices already, and support for
more is already on the way.  I imagine I can have it handle
whatever new ioctls() are being provided from libata as well.

Care to point me at them?

Thanks
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
