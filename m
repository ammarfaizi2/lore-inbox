Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUEWDNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUEWDNv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 23:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEWDNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 23:13:51 -0400
Received: from mx11.sac.fedex.com ([199.81.193.118]:31503 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S262175AbUEWDNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 23:13:50 -0400
Date: Sun, 23 May 2004 11:13:36 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: What's the most compatible gcc/glibc?
Message-ID: <Pine.LNX.4.60.0405231106370.7578@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 05/23/2004
 11:13:44 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 05/23/2004
 11:13:46 AM,
	Serialize complete at 05/23/2004 11:13:46 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using gcc2.95.3 and glib2.2.5-34 and these compiles and runs nearly 
all sources.

But, now I need to compile ipw2100 for Centrino notebook, and that 
requires gcc3.x

Will someone be able to advise on what's the best gcc/glibc to use for 
gcc3.x that would compile/run mozilla, linux.2.6, uml and still runs 
sybase12.x and vmware4.x


Thanks,
Jeff
