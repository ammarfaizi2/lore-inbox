Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264166AbUDVPuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbUDVPuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbUDVPuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:50:00 -0400
Received: from mailscan.first4it.co.uk ([212.69.243.50]:16824 "HELO
	mailscan.first4it.co.uk") by vger.kernel.org with SMTP
	id S264166AbUDVPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:48:50 -0400
Message-ID: <4087E95F.5050409@ihateaol.co.uk>
Date: Thu, 22 Apr 2004 16:48:47 +0100
From: Kieran <kieran@ihateaol.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why is CONFIG_SCSI_QLA2X_X always enabled?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been bugging me for a while.. on pretty much all 2.6 kernel 
configs I've done, the .config has had CONFIG_SCSI_QLA2XXX=y in it, 
regardless of whether or not I have any other SCSI stuff compiled in. Is 
there a reason for this, or is it a bug?

(apologies for the _ in the subject, the lkml server doesn't like XXX in 
the subject..)
