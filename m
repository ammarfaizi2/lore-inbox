Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBHACn>; Wed, 7 Feb 2001 19:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBHACd>; Wed, 7 Feb 2001 19:02:33 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:35599 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129032AbRBHAC0>; Wed, 7 Feb 2001 19:02:26 -0500
Date: Wed, 07 Feb 2001 19:02:14 -0500
From: Chris Mason <mason@suse.com>
To: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs] SPEC SFS fails at low loads...
Message-ID: <820580000.981590534@tiny>
In-Reply-To: <Pine.LNX.4.21.0102071633331.712-100000@penguin.homenet>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 07, 2001 04:35:32 PM +0000 Tigran Aivazian <tigran@veritas.com> wrote:

> Hi,
> 
> Under 2.4.1, after a little bit of running SPEC SFS (with NFSv3) I get
> these messages on the server:
> 
> vs-13042: reiserfs_read_inode2: [0 1 0x0 SD] not found
> vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> vs-13048: reiserfs_iget: bad_inode. Stat data of (0 1) not found
> 
> and the run aborts.
> 
> Any clues?

Andi covered most of the details, you can get a combined version of patches from Neil Brown and I at ftp.reiserfs.org, which I can't seem to get to right now.  If you want a copy, I can send along in private mail.

-chris




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
