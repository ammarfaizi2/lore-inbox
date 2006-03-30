Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWC3QSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWC3QSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWC3QSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:18:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39092 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751224AbWC3QSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:18:38 -0500
Message-ID: <442C04BE.5000602@RedHat.com>
Date: Thu, 30 Mar 2006 11:18:06 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060130 Red Hat/1.7.12-1.4.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: NFS/Kernel Problem: getfh failed: Operation not permitted
References: <Pine.LNX.4.64.0603300813270.18696@p34> <1143728720.8074.41.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603300929340.18696@p34>
In-Reply-To: <Pine.LNX.4.64.0603300929340.18696@p34>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Not running RH9, but running RHEL WS3, Taroon Update 4, however, the 
> nfs-utils is 1.0.6-33EL, I know there were many fixes in 1.0.7+, could 
> nfs-utils be the problem?  The kernel version in question is 
> 2.4.21-31.ELa1smp.
Try updating your nfs-utils to 1.0.6-43EL....

steved.
