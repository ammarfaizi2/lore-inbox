Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTEMPxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTEMPxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:53:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30619
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261355AbTEMPwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:52:05 -0400
Subject: Re: 2.6 must-fix list, v2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <shsy91aonlt.fsf@charged.uio.no>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	 <20030512155511.21fb1652.akpm@digeo.com>
	 <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
	 <shsy91aonlt.fsf@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052838378.463.41.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2003 16:06:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-13 at 16:47, Trond Myklebust wrote:
> The most serious non-NFSv4 problem I believe is the fact that IODirect
> for NFS needs to be completed. I need to bug Chuck about that.
> 
> I also need to look over the VFS file locking changes to see if
> anything has broken lockd.
> 
> any more?

Are all of Steve's fixes for the NFS client from 2.4 propogated into 2.5 
now then ?

