Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSHOOPk>; Thu, 15 Aug 2002 10:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSHOOPk>; Thu, 15 Aug 2002 10:15:40 -0400
Received: from pat.uio.no ([129.240.130.16]:64910 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317005AbSHOOPi>;
	Thu, 15 Aug 2002 10:15:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15707.47212.44395.87243@charged.uio.no>
Date: Thu, 15 Aug 2002 16:19:24 +0200
To: marius@citi.umich.edu
Cc: Brian Pawlowski <beepy@netapp.com>, dax@gurulabs.com,
       torvalds@transmeta.com, kmsmith@umich.edu, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: Will NFSv4 be accepted?
In-Reply-To: <20020815062332.GB9122@umich.edu>
References: <shs8z39dr15.fsf@charged.uio.no>
	<200208142234.g7EMYvQ21700@tooting-fe.eng>
	<20020815062332.GB9122@umich.edu>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == marius aamodt eriksen <marius@umich.edu> writes:

     > and let's not forget such things as getting rid of the
     > representation of users as UIDs over the wire, as well as
     > delegations (i.e. better caching == better performance), named
     > (extended) attributes support, soon-to-come interoperability
     > with a vast array of operating systems, etc. etc.

Right. I wasn't saying that NFSv4 doesn't have anything going for
it. Just that Kerberos isn't the killer argument: it can easily be
integrated with earlier versions of NFS (and in fact Andy and I had
the basic Linux version running on NFSv3 in February *before* it was
tested for NFSv4).

IMHO the main argument for NFSv4 is the improved support for WANs.

Cheers,
  Trond
