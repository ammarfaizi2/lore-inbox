Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284670AbRLDAfw>; Mon, 3 Dec 2001 19:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280983AbRLDAfc>; Mon, 3 Dec 2001 19:35:32 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:54254 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S280838AbRLDAdT>; Mon, 3 Dec 2001 19:33:19 -0500
Date: Tue, 4 Dec 2001 00:32:54 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Stephen Walton <swalton@sunspot.csun.edu>
Cc: Andrew Morton <akpm@zip.com.au>, Steffen Persvold <sp@scali.no>,
        lkml <linux-kernel@vger.kernel.org>,
        nfs list <nfs@lists.sourceforge.net>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [NFS] Re: 2.4.9 kernel crash
Message-ID: <20011204003254.K2857@redhat.com>
In-Reply-To: <3C07E905.DF30E497@zip.com.au> <Pine.LNX.4.33.0112031108470.14786-100000@sunspot.csun.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112031108470.14786-100000@sunspot.csun.edu>; from swalton@sunspot.csun.edu on Mon, Dec 03, 2001 at 11:10:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 03, 2001 at 11:10:31AM -0800, Stephen Walton wrote:
> [Sorry for the long list of CC's but I wasn't sure which to delete.]
> 
> > There was a bug in ext3 which was fixed around about the 2.4.9
> > timeframe.  I don't know if the fix is present in that
> > particular Red Hat kernel.  It was fixed in ext3 0.9.8.
> 
> According to /usr/include/linux/ext3_fs.h, the redhat 2.4.9-13 kernel is
> running ext3 0.9.11.  I've had no trouble with my NFS-exported ext3 disks.

It's 0.9.11 with a couple of critical back-ported fixes, and it
definitely includes the NFS fix.

Cheers,
 Stephen
