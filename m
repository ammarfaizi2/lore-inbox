Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265814AbUFDQ6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUFDQ6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUFDQ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:58:39 -0400
Received: from ozlabs.org ([203.10.76.45]:21978 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265814AbUFDQ4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:56:35 -0400
Date: Sat, 5 Jun 2004 02:55:48 +1000
From: Anton Blanchard <anton@samba.org>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, axboe@suse.de,
       lmb@suse.de, kevcorry@us.ibm.com, arjanv@redhat.com,
       iro@parcelfarce.linux.theplanet.co.uk, trond.myklebust@fys.uio.no,
       lustre-devel@clusterfs.com
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Message-ID: <20040604165548.GC20820@krispykreme>
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602231554.ADC7B3100AE@moraine.clusterfs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> 10. "Have these patches undergone any siginifant test?" by Anton Blanchard:
>  
> There are two important questions I think: 
> - Do the patches cause damage?
>    Probably not anymore. SUSE has done testing and it appears the
>    original patch I attached didn't break things (after one fix was
>    made).

IBM did a lot of the work on that issue and it took the better part of a 
week to find, fix and verify.

Anton
