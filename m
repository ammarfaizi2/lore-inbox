Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSHGWp0>; Wed, 7 Aug 2002 18:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSHGWp0>; Wed, 7 Aug 2002 18:45:26 -0400
Received: from jalon.able.es ([212.97.163.2]:64145 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313087AbSHGWpZ>;
	Wed, 7 Aug 2002 18:45:25 -0400
Date: Thu, 8 Aug 2002 00:49:00 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: eli.carter@inet.com, linux-kernel@vger.kernel.org
Subject: Re: Idle curiosity: Acting as a SCSI target
Message-ID: <20020807224900.GG1537@werewolf.able.es>
References: <200208072151.QAA75961@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200208072151.QAA75961@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Wed, Aug 07, 2002 at 23:51:05 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.08.07 Jesse Pollard wrote:
>Eli Carter <eli.carter@inet.com>:
>> 
>> Based on a conversation I had recently, my curiosity got piqued...
>> 
>> I'm not really sure how to query google on this, and didn't turn up what 
>> I was looking for because of that, so here's the random question:
>> 
>> Is there a way to make a Linux machine with a scsi controller act like a 
>> scsi device (is the correct term 'target'?) (such as a disk) using a 
>> local block device as storage?

Do not know about the software, but hardware allows it. Old mac laptops
were pluggable that way and one could see the other one disk. It was not
a symmetric connection, one laptop acted as disk, but worked...


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre1-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))
