Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266041AbUBCRKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 12:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266039AbUBCRKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 12:10:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266019AbUBCRKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 12:10:02 -0500
Date: Tue, 3 Feb 2004 12:09:56 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, <mpm@selenic.com>
Subject: Re: [PATCH 2.6.1] Add CRC32C chksums to crypto and lib routines
In-Reply-To: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0402031207330.939-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Clay Haapala wrote:

> If this patch looks good, I'd like it accepted so we can submit code
> iSCSI driver code that makes use of it.  This may be a good time,
> since the crypto SHA code is getting a little scrutiny right now.

This will need to wait until 2.6.2 is released, and will you also please 
submit the iSCSI change for review?

Thanks,


- James
-- 
James Morris
<jmorris@redhat.com>


