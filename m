Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266112AbTFWTKc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbTFWTKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 15:10:32 -0400
Received: from relay1.enom.com ([66.150.5.205]:2310 "EHLO Relay1.enom.com")
	by vger.kernel.org with ESMTP id S266112AbTFWTK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 15:10:28 -0400
Message-ID: <20030623122434-034400041>
Message-ID: <3EF753EC.9080807@homemail.com>
Date: Tue, 24 Jun 2003 05:24:28 +1000
From: "D. Sen" <dsen@homemail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide-scsi on 2.4.21 (on IBM Thinkpad T30)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2003 19:24:35.0553 (UTC) FILETIME=[14B53D10:01C339BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.21 causes hangs and/or ooops during boot up if I have a 
"probeall scsi_hostadapter ide-scsi" in my /etc/modules.conf. If I take 
out that line and manually load the module after the laptop has booted, 
everything is fine.

There were no such problems in 2.4.20 or earlier kernels.

Please cc me any responses as I am not on the mailing list.

DS


