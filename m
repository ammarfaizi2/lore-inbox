Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277777AbRJWPjP>; Tue, 23 Oct 2001 11:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277781AbRJWPiz>; Tue, 23 Oct 2001 11:38:55 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31471 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277777AbRJWPix>; Tue, 23 Oct 2001 11:38:53 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 23 Oct 2001 09:39:19 -0600
To: szonyi calin <caszonyi@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Strange lilo behaviour with kernel 2.4.10/2.4.12 and devfs
Message-ID: <20011023093919.A23590@turbolinux.com>
Mail-Followup-To: szonyi calin <caszonyi@yahoo.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011023142922.57681.qmail@web13107.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011023142922.57681.qmail@web13107.mail.yahoo.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 23, 2001  07:29 -0700, szonyi calin wrote:
> I'm having a very strange problem with lilo.
> I run lilo it looks like it is writing the partition
> table but it's not.
> Problem begun in 2.4.10 and continued in 2.4.12

Well, there WAS a problem in 2.4.10 that would cause this, but it should be 
fixed in 2.4.12.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

