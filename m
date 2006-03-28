Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWC1QPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWC1QPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWC1QPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:15:46 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:22961 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751216AbWC1QPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:15:46 -0500
Message-ID: <44296129.4090902@cfl.rr.com>
Date: Tue, 28 Mar 2006 11:15:37 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: yenganti pradeep <pradeepls143@yahoo.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: procfs question
References: <20060328153449.3321.qmail@web8409.mail.in.yahoo.com>
In-Reply-To: <20060328153449.3321.qmail@web8409.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2006 16:15:49.0579 (UTC) FILETIME=[E0B481B0:01C65282]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14351.000
X-TM-AS-Result: No--0.700000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yenganti pradeep wrote:
> length=sprintf(page,"Value %d",var++);
<snip>
> Why is this three numbers increment? 

Ummm... because you are incrementing it?  var++ means increment var.
