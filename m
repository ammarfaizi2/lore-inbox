Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUCVGYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUCVGYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:24:19 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:8163 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261763AbUCVGYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:24:18 -0500
Date: Mon, 22 Mar 2004 11:58:42 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Carsten Otte <COTTE@de.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>
Subject: Re: [RFC 0/6] sysfs backing store v0.3
Message-ID: <20040322062842.GA5898@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040318063306.GA27107@in.ibm.com> <20040320175708.GQ11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320175708.GQ11010@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 11:57:09AM -0600, Matt Mackall wrote:
> On Thu, Mar 18, 2004 at 12:03:06PM +0530, Maneesh Soni wrote:
> > Hi,
> > 
> > Please find the following patch set for sysfs backing store. Thanks
> > to Carsten Otte and S390 Linux guys for reporting the bug while
> > unloading zfcp driver.
> 
> Could you rediff this to apply against 2.6.5-rc2? It's getting a fair
> number of rejects.
> 

Please find the following patches for sysfs backing store v0.3 against 
2.6.5-rc2. No, changes just fixed the rejects and re-diffed.

Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
