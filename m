Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280987AbRKOSk1>; Thu, 15 Nov 2001 13:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280985AbRKOSkS>; Thu, 15 Nov 2001 13:40:18 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:2544 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280987AbRKOSkC>;
	Thu, 15 Nov 2001 13:40:02 -0500
Date: Thu, 15 Nov 2001 11:39:53 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jackie Meese <jackie.m@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 32 Groups Maximum in 2.4
Message-ID: <20011115113953.H5739@lynx.no>
Mail-Followup-To: Jackie Meese <jackie.m@vt.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BF3DF31.4010707@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BF3DF31.4010707@vt.edu>; from jackie.m@vt.edu on Thu, Nov 15, 2001 at 10:28:49AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  10:28 -0500, Jackie Meese wrote:
> I've been looking for some time on how to raise the maximum number of 
> groups for the 2.4 kernel.  I've discovered how to do this kernel, with 
> a discussion a few months ago on this 
> list.http://www.cs.helsinki.fi/linux/linux-kernel/2001-13/0807.html

Have you considered ACLs instead?  http://acl.bestbits.at/
Also available for ext3 (I think reiserfs may also support ACLs, not sure).
It might not suit your needs, but maybe it does, and it is a better long-term
solution.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

