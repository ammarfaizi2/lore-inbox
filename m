Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282912AbRLGQmx>; Fri, 7 Dec 2001 11:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282907AbRLGQmk>; Fri, 7 Dec 2001 11:42:40 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:51943 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282912AbRLGQmS>; Fri, 7 Dec 2001 11:42:18 -0500
Date: Fri, 07 Dec 2001 08:44:03 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>, Henning Schmiedehausen <hps@intermeta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <2692295916.1007714643@[10.10.1.2]>
In-Reply-To: <20011207080603.B6983@work.bitmover.com>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm taking mercy on people and trimming down the cc: list ...

>> What I don't like about the approach is the fact that all nodes should
>> share the same file system. One (at least IMHO) does not want this for
>> at least /etc. 
> 
> Read through my other postings, I said that things are private by
> default.

So if I understand you correctly, you're saying you have a private /etc for 
each instance of the sub-OS. Doesn't this make management of the system 
a complete pig? And require modifying many user level tools?

M.
