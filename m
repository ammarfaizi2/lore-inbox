Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUHTQCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUHTQCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUHTQCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:02:41 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:18343 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S267334AbUHTQCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:02:40 -0400
Message-ID: <412620AB.9090603@netcabo.pt>
Date: Fri, 20 Aug 2004 17:02:51 +0100
From: Joao Estevao <tranquility@netcabo.pt>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040804)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sil3112 2.6.8.1 woes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Aug 2004 16:02:39.0706 (UTC) FILETIME=[1E3FB3A0:01C486CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I recently upgraded to 2.6.8.1 and my SATA disk stopped working.
As far as I can see, when the kernel boots the usual information about
my controller found by 2.6.7 is not shown. I still have 
CONFIG_SCSI_SATA_SIL=y and yet it won't find my root not even if I use root=/dev/sda5 or root=/dev/scsi/host0/bus0/target0/lun0/part5. With 
2.6.7 I used root=/dev/discs/disc0/part5 and worked fine. Somebody has 
any ideia why this is happening?

TIA,

Joao Estevao.

