Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbUCTR5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbUCTR5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:57:42 -0500
Received: from waste.org ([209.173.204.2]:15239 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263497AbUCTR5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:57:35 -0500
Date: Sat, 20 Mar 2004 11:57:09 -0600
From: Matt Mackall <mpm@selenic.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Carsten Otte <COTTE@de.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>
Subject: Re: [RFC 0/6] sysfs backing store v0.3
Message-ID: <20040320175708.GQ11010@waste.org>
References: <20040318063306.GA27107@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318063306.GA27107@in.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:03:06PM +0530, Maneesh Soni wrote:
> Hi,
> 
> Please find the following patch set for sysfs backing store. Thanks
> to Carsten Otte and S390 Linux guys for reporting the bug while
> unloading zfcp driver.

Could you rediff this to apply against 2.6.5-rc2? It's getting a fair
number of rejects.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
