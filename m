Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285792AbRLTB7C>; Wed, 19 Dec 2001 20:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285799AbRLTB6x>; Wed, 19 Dec 2001 20:58:53 -0500
Received: from [207.88.206.43] ([207.88.206.43]:45193 "HELO
	intruder-luxul.gurulabs.com") by vger.kernel.org with SMTP
	id <S285792AbRLTB6n>; Wed, 19 Dec 2001 20:58:43 -0500
Date: Wed, 19 Dec 2001 18:58:41 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: <dkelson@mooru.gurulabs.com>
To: David Chow <davidchow@rcn.com.hk>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: nfsroot dead slow with redhat 7.2
In-Reply-To: <1008812943.16827.1.camel@star9.planet.rcn.com.hk>
Message-ID: <Pine.LNX.4.33.0112191858050.5309-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Dec 2001, David Chow wrote:

> Dear Trond,
> 
> Thanks for answering my question, we have use the i386 kernel at the
> server that works fine. Also even we uses the i686 kerenl at the server,
> it happens normally when doing NFS mounts, it will only be dead slow
> when
> 	server i686 2.4.7-10 kernel && client nfsroot(2.4.13 i686)
> 
> The network is fine. It is so slow that an ls -l at the rootfs takes
> more than 2 minutes. The readdir() seems alright because the ls
> immediate counts the number of records says "total blahbalh" but when

Is a "ls -ln" any faster?

Dax

