Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267491AbUHZEik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbUHZEik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHZEik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:38:40 -0400
Received: from jade.spiritone.com ([216.99.193.136]:12518 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267491AbUHZEij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:38:39 -0400
Date: Wed, 25 Aug 2004 21:38:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: jmerkey@comcast.net, linux-kernel@vger.kernel.org
cc: jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-ID: <17710000.1093495110@[10.10.2.4]>
In-Reply-To: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That incredibly useful patch for 2.4.X that Andrea wrote that splits the kernel user space 
> into 1GB/2GB/3GB sections  I ported to 2.6.8.1 and posted it to:
> 
> ftp.kernel.org:/pub/linux/kernel/people/jmerkey/patches/linux-2.6.8.1-highmem-split-08-25-04.patch
> 
> I was not able to located a 2.6.8 version of this patch so I ported one.  I apologize in advance
> if I replicated anyone elses work.
> 
> Using HIGHMEM (aka.  the extended Linux TLB reloading hits/second test) is not optimal for embedded systems and appliance versions of Linux we use so this is submitted.  I'll maintain
> this patch (and keep it working) for folks who need it.
> 
> Would be nice to have in the kernel for appliance Linux.
> 
> ** I CERTIFY THAT THIS CODE DOES NOT CONTAIN ANY INTELECTUAL PROPERTY 
> OF ANYONE OTHER THAN THE ORIGINAL LINUX CONTRIBUTORS THE FILES
> WERE DERIVED FROM. ***

We've tried to get Linus to take that patch multiple times. He said no.

M.

