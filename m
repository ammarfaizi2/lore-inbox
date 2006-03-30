Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWC3Qvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWC3Qvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWC3Qvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:51:38 -0500
Received: from lucidpixels.com ([66.45.37.187]:40584 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751169AbWC3Qvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:51:38 -0500
Date: Thu, 30 Mar 2006 11:51:36 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Steve Dickson <SteveD@redhat.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: NFS/Kernel Problem: getfh failed: Operation not
 permitted
In-Reply-To: <442C04BE.5000602@RedHat.com>
Message-ID: <Pine.LNX.4.64.0603301151200.18696@p34>
References: <Pine.LNX.4.64.0603300813270.18696@p34> <1143728720.8074.41.camel@lade.trondhjem.org>
 <Pine.LNX.4.64.0603300929340.18696@p34> <442C04BE.5000602@RedHat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I will give this a try sometime soon and hopefully it'll fix the 
issue :)

Justin.

On Thu, 30 Mar 2006, Steve Dickson wrote:

> Justin Piszcz wrote:
>> Not running RH9, but running RHEL WS3, Taroon Update 4, however, the 
>> nfs-utils is 1.0.6-33EL, I know there were many fixes in 1.0.7+, could 
>> nfs-utils be the problem?  The kernel version in question is 
>> 2.4.21-31.ELa1smp.
> Try updating your nfs-utils to 1.0.6-43EL....
>
> steved.
>
