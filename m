Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTLPHq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 02:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTLPHq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 02:46:29 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61128 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264364AbTLPHq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 02:46:28 -0500
Message-ID: <3FDEB84D.1080806@us.ibm.com>
Date: Mon, 15 Dec 2003 23:46:21 -0800
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: RunNHide <res0g1ta@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Initio SCSI Drivers
References: <3FD82252.6050300@verizon.net>
In-Reply-To: <3FD82252.6050300@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RunNHide wrote:
> Can anyone help out? Tried building 2.6.0-test11 today and, lo and 
> behold, noticed the support for my Initio SCSI card has been removed - 

Could you try this patch 
http://marc.theaimsgroup.com/?l=linux-scsi&m=107118845311085&w=2

Thanks,

Mike Christie
mikenc@us.ibm.com

