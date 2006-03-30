Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWC3Ouy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWC3Ouy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWC3Ouy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:50:54 -0500
Received: from lucidpixels.com ([66.45.37.187]:42157 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750708AbWC3Oux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:50:53 -0500
Date: Thu, 30 Mar 2006 09:50:52 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: NFS/Kernel Problem: getfh failed: Operation not permitted
In-Reply-To: <1143729766.8074.49.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0603300949000.18696@p34>
References: <Pine.LNX.4.64.0603300813270.18696@p34> 
 <1143728720.8074.41.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0603300929340.18696@p34>
 <1143729766.8074.49.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried an exportfs -rv and it did not help.  Any other suggestions?

On Thu, 30 Mar 2006, Trond Myklebust wrote:

> On Thu, 2006-03-30 at 09:30 -0500, Justin Piszcz wrote:
>
>> The kernel version in question is  2.4.21-31.ELa1smp.
>
> I take it that the standard 'exportfs -rv' doesn't help? Normally, that
> should suffice to stuff /proc/fs/nfs/exports with the entries
> in /etc/exports.
>
> Cheers,
>  Trond
>
