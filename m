Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTLPNc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 08:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTLPNc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 08:32:58 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:36549 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261681AbTLPNc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 08:32:57 -0500
Message-ID: <3FDF0987.3040400@verizon.net>
Date: Tue, 16 Dec 2003 08:32:55 -0500
From: RunNHide <res0g1ta@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5.1) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Christie <mikenc@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Initio SCSI Drivers
References: <3FD82252.6050300@verizon.net> <3FDEB84D.1080806@us.ibm.com>
In-Reply-To: <3FDEB84D.1080806@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [4.4.161.12] at Tue, 16 Dec 2003 07:32:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sure will give it a shot - will do it when I get home from work this 
evening and will report my findings.
------------------------------------------------------------------------------------------------------
RunNHide wrote:

> Can anyone help out? Tried building 2.6.0-test11 today and, lo and 
> behold, noticed the support for my Initio SCSI card has been removed - 


Could you try this patch 
http://marc.theaimsgroup.com/?l=linux-scsi&m=107118845311085&w=2

Thanks,

Mike Christie
mikenc@us.ibm.com

