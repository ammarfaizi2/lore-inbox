Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287658AbSAIPtQ>; Wed, 9 Jan 2002 10:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287684AbSAIPtH>; Wed, 9 Jan 2002 10:49:07 -0500
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:3792 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S287658AbSAIPsu>; Wed, 9 Jan 2002 10:48:50 -0500
Date: Wed, 09 Jan 2002 10:47:59 -0500
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
cc: adilger@turbolabs.com
Subject: Re: [reiserfs-dev] [PATCH] UUID & volume labels support for
 reiserfs
Message-ID: <52160000.1010591279@tiny>
In-Reply-To: <20020109155504.A4551@namesys.com>
In-Reply-To: <20020109155504.A4551@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 09, 2002 03:55:04 PM +0300 Oleg Drokin
<green@namesys.com> wrote:

> Hello!
> 
>     Attached is the patch that reserves space for volume label and UUID
> in reiserfs v3.6 superblock.     It also generates random UUID for
> volumes converted from 3.5 to 3.6 format by the kernel.     Original
> patch author is Andreas Dilger <adilger@turbolabs.com>.     Please apply.

This should not be applied until an updated (non beta) reiserfsprogs
package that supports these features has been released.

-chris

