Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130937AbRBTXcv>; Tue, 20 Feb 2001 18:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRBTXck>; Tue, 20 Feb 2001 18:32:40 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:23567 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130937AbRBTXcT>; Tue, 20 Feb 2001 18:32:19 -0500
Date: Tue, 20 Feb 2001 18:30:54 -0500
From: Chris Mason <mason@suse.com>
To: Brian May <bam@snoopy.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
Message-ID: <1919950000.982711854@tiny>
In-Reply-To: <84ae7hge3o.fsf@snoopy.apana.org.au>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 21, 2001 09:54:19 AM +1100 Brian May
<bam@snoopy.apana.org.au> wrote:

>>>>>> "dek" == dek ml <dek_ml@konerding.com> writes:
> 
>     dek> OK so I think what I can take from this is: for kernel 2.4 in
>     dek> the foreseeable future, reiserfs over NFS won't work without
>     dek> a special patch.  And, filesystems other than ext2 in general
> 
> Does this apply to the user space NFS server? kernel space NFS server?
> Or both?

Both, but in different ways.  Andi Kleen has a set patches for using the
userspace NFS server with reiserfs:

ftp.suse.com/pub/people/ak/nfs

-chris

