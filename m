Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUDPIiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 04:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDPIiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 04:38:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:26283 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262815AbUDPIiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 04:38:15 -0400
Date: Fri, 16 Apr 2004 14:12:40 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040416084240.GA1652@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040402043814.GA6993@in.ibm.com> <Pine.LNX.4.44L0.0404021629210.889-100000@ida.rowland.org> <20040406101320.GB1270@in.ibm.com> <20040414132015.GD5422@in.ibm.com> <20040415213600.GD13578@kroah.com> <20040415151059.1136058e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415151059.1136058e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 03:10:59PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > This patch looks sane, Andrew, can you let it sit in your -mm tree for a
> > while to see if anything breaks with it?
> 
> It needs work to make it live alongside ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm6/broken-out/sysfs-d_fsdata-race-fix-2.patch
> 
> What are we doing with sysfs-d_fsdata-race-fix-2 btw?

Hi Andrew, 
Greg, is talking for the same patch, which is included in -mm6 now. 
 
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
