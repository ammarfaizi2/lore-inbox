Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTH2Lpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbTH2Lpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:45:42 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:14011 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263465AbTH2Lpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:45:41 -0400
From: "Thomas XB Spatzier" <TSPAT@de.ibm.com>
Subject: Re: [PATCH] memory leak in sysfs
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFC6C00246.CCB11686-ONC1256D91.0040742D-C1256D91.0040ABA6@de.ibm.com>
Date: Fri, 29 Aug 2003 13:46:22 +0200
X-MIMETrack: Serialize by Router on D12ML041/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 29/08/2003 13:46:00
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It turns out some of the code had changed, to deal with another small bug
> when dentry creation failed. The patch below is updated to -test4.  Could
> you please test it and let me know if it still works?

I've looked over the changes and the code seems to work.


Best regards,

Thomas

