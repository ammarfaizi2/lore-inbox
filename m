Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWBJPPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWBJPPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWBJPPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:15:44 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:47899 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932131AbWBJPPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:15:43 -0500
Message-ID: <43ECADE6.9020609@cfl.rr.com>
Date: Fri, 10 Feb 2006 10:14:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support HDIO_GETGEO on device-mapper volumes
References: <43EBEDD0.60608@us.ibm.com> <43EC218A.9000402@cfl.rr.com> <43EC4B57.9000408@us.ibm.com>
In-Reply-To: <43EC4B57.9000408@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 15:16:44.0719 (UTC) FILETIME=[00CD4BF0:01C62E55]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14259.000
X-TM-AS-Result: No--2.200000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> Phillip... are you the person working on dmraid support in Ubuntu?  
> For the first time, I boot Ubuntu off that HostRAID array this 
> afternoon without the need for a helper disk and with dmraid in the 
> initramfs.  I appreciated the howto. :)
>

Yes, I'm currently working on getting it nicely packaged, udebified, and 
integrated into the installer.  Might not make it in time for dapper. 


