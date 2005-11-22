Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVKVJp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVKVJp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVKVJp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:45:57 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:7098 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1751288AbVKVJp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:45:56 -0500
Message-ID: <4382E2BA.5030407@wolfmountaingroup.com>
Date: Tue, 22 Nov 2005 02:19:54 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
References: <E1EeLp5-0002fZ-00@calista.inka.de> <43825168.6050404@wolfmountaingroup.com> <20051122074553.GA20476@infradead.org>
In-Reply-To: <20051122074553.GA20476@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Mon, Nov 21, 2005 at 03:59:52PM -0700, Jeff V. Merkey wrote:
>  
>
>>Linux is currently limited to 16 TB per VFS mount point, it's all mute, 
>>unless VFS gets fixed.
>>mmap won't go above this at present.
>>    
>>
>
>You're thinking of 32bit architectures.  There is no such limit for
>64 bit architectures.  There are XFS volumes in the 100TB range in production
>use.
>
>
>  
>
I have 128 TB volumes in production use on 32 bit processors.

Jeff
