Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUBFUT6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUBFUT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:19:58 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:18616
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265540AbUBFUTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:19:55 -0500
Message-ID: <4023F775.3090900@tmr.com>
Date: Fri, 06 Feb 2004 15:22:13 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux
 kernel
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96CF@mercury.infiniconsys.com>
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96CF@mercury.infiniconsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tillier, Fabian wrote:
> So which is more important to the "Linux kernel" project: i386 backwards
> compatibility, or consistent API and functionality across processor
> architectures? ;)

For clever programmers they are not incompatible.

> 
> - Fab
> 
> 
> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Thursday, February 05, 2004 12:28 PM
> To: Tillier, Fabian
> Cc: Randy.Dunlap; sean.hefty@intel.com; linux-kernel@vger.kernel.org;
> hozer@hozed.org; woody@co.intel.com; bill.magro@intel.com;
> woody@jf.intel.com; infiniband-general@lists.sourceforge.net
> Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
> theLinux kernel
> 
> On Thu, Feb 05, 2004 at 02:26:19PM -0500, Tillier, Fabian wrote:
> 
>>Do note that for non x86 architectures, the component library atomic
>>abstraction is all #define to the Linux provided functions.  Only x86
>>needed help because of i386 backwards compatibility which is not a
> 
> goal
> 
>>of the InfiniBand project.
> 
> 
> But that is a goal of the "Linux kernel" project :)
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
