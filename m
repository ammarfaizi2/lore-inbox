Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSJVTpC>; Tue, 22 Oct 2002 15:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSJVTpC>; Tue, 22 Oct 2002 15:45:02 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:27387 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265132AbSJVTpA>; Tue, 22 Oct 2002 15:45:00 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 22 Oct 2002 13:47:39 -0600
To: Rob Landley <landley@trommello.org>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, davej@suse.de,
       davem@redhat.com, mingo@redhat.com
Subject: Re: [STATUS 2.5]  October 21, 2002
Message-ID: <20021022194739.GB28822@clusterfs.com>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
	linux-kernel@vger.kernel.org, akpm@zip.com.au, davej@suse.de,
	davem@redhat.com, mingo@redhat.com
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost> <200210211522.35843.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210211522.35843.landley@trommello.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 October 2002 06:22, Guillaume Boissiere wrote:
> Also, are initramfs, ext2/3 resize for 2.7/3.1?

The online resize stuff has been suffering because I've been terribly
busy at work.  Even so, it can be merged after the 2.5 code freeze,
since it is internal to ext3 and does not affect any APIs.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

