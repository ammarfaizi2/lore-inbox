Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319284AbSHNWb0>; Wed, 14 Aug 2002 18:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319319AbSHNWb0>; Wed, 14 Aug 2002 18:31:26 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:28593 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S319284AbSHNWb0>; Wed, 14 Aug 2002 18:31:26 -0400
From: Brian Pawlowski <beepy@netapp.com>
Message-Id: <200208142234.g7EMYvQ21700@tooting-fe.eng>
Subject: Re: [NFS] Re: Will NFSv4 be accepted?
In-Reply-To: <shs8z39dr15.fsf@charged.uio.no> from Trond Myklebust at "Aug 15, 2 00:17:10 am"
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Wed, 14 Aug 2002 15:34:57 -0700 (PDT)
Cc: dax@gurulabs.com, torvalds@transmeta.com, kmsmith@umich.edu,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
X-Mailer: ELM [version 2.4ME++ PL40 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> RPCSEC_GSS is not an argument for NFSv4...

yes.

But ACL support over the wire is an argument for V4 - and fine grained
authorization coupled to strong authentication makes for a flexible 
security package.
