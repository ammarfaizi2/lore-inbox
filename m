Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUH0P5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUH0P5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUH0P5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:57:37 -0400
Received: from jade.spiritone.com ([216.99.193.136]:51642 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266333AbUH0PsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:48:02 -0400
Date: Fri, 27 Aug 2004 08:47:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CacheFS - general filesystem cache
Message-ID: <70360000.1093621660@[10.10.2.4]>
In-Reply-To: <20040827112813.A30219@infradead.org>
References: <17777.1093566183@redhat.com> <20040827112813.A30219@infradead.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I've packaged my generic filesystem cache filesystem into patches and also
>> produced patches for my AFS filesystem to use it. Work is also in progress to
>> alter the NFS client use this interface too, and I think the ISO9660
>> filesystem could also benefit.
>> 
>> I've put a tarball of them on my Red Hat webpage because one of them is rather
>> large. If you grab:
>> 
>> 	http://people.redhat.com/~dhowells/cachefs/cachefs-patches.tar.bz2
> 
> Umm, a tarball is the worst possible distribution method for patches.

Nah, they have rpms as well ... those are even worse ;-)

M.

