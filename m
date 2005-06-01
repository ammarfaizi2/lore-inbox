Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFAVSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFAVSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVFAVJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:09:56 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:24404 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261305AbVFAVI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:08:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PwHMoY65xmoxuHME1CjWXUxmLiVKreKcI7+LD1lIUwBkOCYj5Sl8J2pGL+ZN/FSfrb3RQ57BNOK0ILnWA/zUYNpeTyvqAg9ii2xrHMxcz0zU2TWVWcdZAPx6Ay4tq/nt/atoof5qiIJxOAOIGGEqKd2jQu3Wpf82sVbL3nQMGIo=  ;
Message-ID: <429E23E3.8000606@yahoo.com>
Date: Wed, 01 Jun 2005 14:08:51 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McFarland <pmcfarland@downeast.net>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance Initiator
References: <429E15CD.2090202@yahoo.com> <200506011654.11362.pmcfarland@downeast.net>
In-Reply-To: <200506011654.11362.pmcfarland@downeast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland wrote:
> On Wednesday 01 June 2005 04:08 pm, Alex Aizman wrote:
> 
>> This is open-iscsi/linux-iscsi-5 Initiator. This submission is ready for 
>> inclusion into mainline kernel.
> 
> 
> Awesome! So is this complete enough so I can, say, play DVDs from one box 
> using an ATAPI DVD drive in another box?
> 

Yep, that's what iSCSI is for, in part. You'll need iSCSI target to connect to
the SCSI backend, e.g. http://iscsitarget.sourceforge.net/
