Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318622AbSHPQiO>; Fri, 16 Aug 2002 12:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318623AbSHPQiN>; Fri, 16 Aug 2002 12:38:13 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:40200 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318622AbSHPQiM>;
	Fri, 16 Aug 2002 12:38:12 -0400
Date: Fri, 16 Aug 2002 09:37:39 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
Message-ID: <20020816163739.GB4916@kroah.com>
References: <3D5C6410.1020706@us.ibm.com> <20020816043140.GA2478@kroah.com> <3D5CBCFC.2090006@us.ibm.com> <20020816143925.GA3957@kroah.com> <3D5D25FE.8010002@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5D25FE.8010002@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 19 Jul 2002 14:20:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 09:19:10AM -0700, Dave Hansen wrote:
> 
> How long has it been in the tree (2.4 and 2.5)?

2.5

> I'll add it to my machine, but I am anticipating a 3 hour conversation
> as I explain to the other users why they got dropped to a root prompt
> because driverfs isn't supported when they boot.

???  My machines don't do that, they just complain and then continue on
with the boot sequence.

greg k-h
