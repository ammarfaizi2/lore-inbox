Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSHOBJJ>; Wed, 14 Aug 2002 21:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSHOBJJ>; Wed, 14 Aug 2002 21:09:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49658 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316309AbSHOBJH>; Wed, 14 Aug 2002 21:09:07 -0400
Subject: Re: [NFS] Re: Will NFSv4 be accepted?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Pawlowski <beepy@netapp.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, dax@gurulabs.com,
       Linus Torvalds <torvalds@transmeta.com>, kmsmith@umich.edu,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <200208142234.g7EMYvQ21700@tooting-fe.eng>
References: <200208142234.g7EMYvQ21700@tooting-fe.eng>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 02:10:29 +0100
Message-Id: <1029373829.28240.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 23:34, Brian Pawlowski wrote:
> But ACL support over the wire is an argument for V4 - and fine grained
> authorization coupled to strong authentication makes for a flexible 
> security package.

ACL works in NFSv2 and nicely in NFSv3 - again the problems Linux has
are the client failing to respect basic NFS rules of operation.

