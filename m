Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVBQUeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVBQUeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBQUeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:34:06 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19864 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262295AbVBQUbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:31:37 -0500
Message-ID: <4214FF28.4020605@sgi.com>
Date: Thu, 17 Feb 2005 14:31:36 -0600
From: Carrie Knox <knox@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-1-766_FC3 with glibc 2.3.4-2.fc3 and IRIX xfs version type=1
 filesystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Workstations installed with Fedora Core 3 are having problems running 
tcl scripts.  The failure has been isolated to be occurring only when 
the tcl script is accessing NFS mounted IRIX version type=1 
filesystems.  Upgraded to 2.6.10-1-766_FC3 and  glibc 2.3.4-2.fc3 and 
the problem still exists.

I've found a thread titled "Re: Irix NFS servers, again :-)" in the 
linux-kernel archives which describes the failure.

I'm wondering if there will be any type of patch available for the 2.6 
kernel or for glibc to workaround this issue.

Thanks,

Please CC me on any replies as I am not subscribed to the linux-kernel 
mailing list.

Thanks,
Carrie

--
Carrie Knox		   Information Services
Systems Administrator	   knox@sgi.com 


