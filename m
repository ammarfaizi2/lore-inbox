Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRC3DGt>; Thu, 29 Mar 2001 22:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130470AbRC3DGk>; Thu, 29 Mar 2001 22:06:40 -0500
Received: from asbestos.brocade.com ([63.121.140.244]:16847 "EHLO
	mail.brocade.com") by vger.kernel.org with ESMTP id <S130466AbRC3DGb>;
	Thu, 29 Mar 2001 22:06:31 -0500
Message-ID: <3AC3F91B.4020804@muppetlabs.com>
Date: Thu, 29 Mar 2001 19:10:19 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-8 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in the ramfs file system
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >(none):/mnt/ramfs/root# df -h /mnt/ramfs/
 >Filesystem            Size  Used Avail Use% Mounted on
 >ramfs                    0     0     0   -  /mnt/ramfs
I am not sure, how related this is, but we have / on ramfs and using rpm 
to install(-iUvh) fails with the mesages, need 12K on /


Amit

