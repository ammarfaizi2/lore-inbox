Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSKUUxr>; Thu, 21 Nov 2002 15:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSKUUxr>; Thu, 21 Nov 2002 15:53:47 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:15496 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264745AbSKUUxm>; Thu, 21 Nov 2002 15:53:42 -0500
Subject: Re: RFC - new raid superblock layout for md driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Dake <sdake@mvista.com>
Cc: Doug Ledford <dledford@redhat.com>, Joel Becker <Joel.Becker@oracle.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
In-Reply-To: <3DDD3AB6.2010105@mvista.com>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<20021120160259.GW806@nic1-pc.us.oracle.com>
	<15836.7011.785444.979392@notabene.cse.unsw.edu.au>
	<20021121014625.GA14063@redhat.com>
	<20021121193424.GB770@nic1-pc.us.oracle.com>
	<20021121195406.GF14063@redhat.com>  <3DDD3AB6.2010105@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 21:29:36 +0000
Message-Id: <1037914176.9122.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 19:57, Steven Dake wrote:
> Doug,
> 
> EVMS integrates all of this stuff together into one cohesive peice of 
> technology.
> 
> But I agree, LVM should be modified to support RAID 1 and RAID 5, or MD 
> should be modified to support volume management.  Since RAID 1 and RAID 
> 5 are easier to implement, LVM is probably the best place to put all 
> this stuff.

User space issue. Its about the tools view not about the kernel drivers.

