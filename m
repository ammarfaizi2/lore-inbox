Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSHOLGy>; Thu, 15 Aug 2002 07:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSHOLGx>; Thu, 15 Aug 2002 07:06:53 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26619 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316757AbSHOLGx>; Thu, 15 Aug 2002 07:06:53 -0400
Subject: Re: [NFS] Re: Will NFSv4 be accepted?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: marius@citi.umich.edu
Cc: Brian Pawlowski <beepy@netapp.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, dax@gurulabs.com,
       Linus Torvalds <torvalds@transmeta.com>, kmsmith@umich.edu,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <20020815061848.GA9122@umich.edu>
References: <200208142234.g7EMYvQ21700@tooting-fe.eng>
	<1029373829.28240.16.camel@irongate.swansea.linux.org.uk> 
	<20020815061848.GA9122@umich.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 12:08:27 +0100
Message-Id: <1029409707.29812.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 07:18, marius aamodt eriksen wrote:

> > ACL works in NFSv2 and nicely in NFSv3 - again the problems Linux has
> > are the client failing to respect basic NFS rules of operation.
> 
> there is no over-the-wire specification for sending or receving ACLs
> on NFSv{2,3} - hence the server may choose to obey them, but an
> arbitrary client cannot set them, or view them.

If you are trying to argue that NFSv4 handles ACL's better you are
preaching to the choir

