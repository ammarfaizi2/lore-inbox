Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRGTAub>; Thu, 19 Jul 2001 20:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRGTAuV>; Thu, 19 Jul 2001 20:50:21 -0400
Received: from stine.vestdata.no ([195.204.68.10]:15634 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S266377AbRGTAuH>; Thu, 19 Jul 2001 20:50:07 -0400
Date: Fri, 20 Jul 2001 02:49:56 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <xfs@ragnark.vestdata.no>
To: Tad Dolphay <tbd@sgi.com>
Cc: mjacob@feral.com, Christian Chip <chip.christian@storageapps.com>,
        linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Busy inodes after umount
Message-ID: <20010720024956.B20732@vestdata.no>
In-Reply-To: <20010719165758.D50024-100000@wonky.feral.com> <200107200038.TAA40153@fsgi158.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <200107200038.TAA40153@fsgi158.americas.sgi.com>; from Tad Dolphay on Thu, Jul 19, 2001 at 07:38:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 07:38:15PM -0500, Tad Dolphay wrote:
> I know there was a fix for a "Busy inodes after unmount" problem in
> 2.4.6-pre3. Here's an excerpt from a posting to the NFS mailing list
> from Neil Brown:

Thanks. I'll try that and see if that solves the problem (also the XFS
UUID problem).


-- 
Ragnar Kjorstad
Big Storage
