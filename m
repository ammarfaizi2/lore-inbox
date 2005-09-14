Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbVINVmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbVINVmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbVINVmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:42:06 -0400
Received: from orb.pobox.com ([207.8.226.5]:64935 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932778AbVINVmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:42:05 -0400
Message-ID: <43289926.1080108@rtr.ca>
Date: Wed, 14 Sep 2005 17:41:58 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Phil Dier <phil@icglink.com>
Cc: linux-kernel@vger.kernel.org, ziggy <ziggy@icglink.com>,
       Jack Massari <jack@icglink.com>, Scott Holdren <scott@icglink.com>
Subject: Re: Slow I/O with SMP, Fusion-MPT and u160 SCSI JBOD
References: <20050914150109.232c6765.phil@icglink.com>
In-Reply-To: <20050914150109.232c6765.phil@icglink.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Dier wrote:
> Hi,
> 
> I just tried the 2.6.14-rc1 kernel to see if it exhibits the behaviour
> I have described before[0]. It still does. Briefly, I have a dual Xeon
..

Do you still have HZ set to 1000 in your .config file? (as per 2.6.12)
