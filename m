Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSHOGTi>; Thu, 15 Aug 2002 02:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSHOGTi>; Thu, 15 Aug 2002 02:19:38 -0400
Received: from citi.umich.edu ([141.211.92.141]:63267 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S316585AbSHOGTh>;
	Thu, 15 Aug 2002 02:19:37 -0400
Date: Thu, 15 Aug 2002 02:23:32 -0400
From: marius aamodt eriksen <marius@umich.edu>
To: Brian Pawlowski <beepy@netapp.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, dax@gurulabs.com,
       torvalds@transmeta.com, kmsmith@umich.edu, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: Will NFSv4 be accepted?
Message-ID: <20020815062332.GB9122@umich.edu>
Reply-To: marius@citi.umich.edu
References: <shs8z39dr15.fsf@charged.uio.no> <200208142234.g7EMYvQ21700@tooting-fe.eng>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208142234.g7EMYvQ21700@tooting-fe.eng>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Brian Pawlowski <beepy@netapp.com> [020814 18:36]:
> > RPCSEC_GSS is not an argument for NFSv4...
> 
> yes.
> 
> But ACL support over the wire is an argument for V4 - and fine grained
> authorization coupled to strong authentication makes for a flexible 
> security package.

and let's not forget such things as getting rid of the representation
of users as UIDs over the wire, as well as delegations (i.e. better
caching == better performance), named (extended) attributes support,
soon-to-come interoperability with a vast array of operating systems,
etc. etc.

marius.

-- 
> marius@umich.edu > http://www.citi.umich.edu/u/marius
