Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277390AbRJOLSR>; Mon, 15 Oct 2001 07:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277392AbRJOLSH>; Mon, 15 Oct 2001 07:18:07 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:4572 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S277390AbRJOLRz>; Mon, 15 Oct 2001 07:17:55 -0400
Date: Mon, 15 Oct 2001 19:18:19 +0800 (PHT)
From: Federico Sevilla III <jijo@leathercollection.ph>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13-pre1: sonypi.c compile error
In-Reply-To: <200110151055.MAA12072@arpa.it.uc3m.es>
Message-ID: <Pine.LNX.4.40.0110151915270.13838-100000@gusi.leathercollection.ph>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 at 12:55, Peter T. Breuer wrote:
> There seemed to be a need for an acl.h somewhere too, but maybe that
> was my xfs patch.

That was your XFS patch. It's fixed in CVS of XFS but can also be fixed by
removing all references to include/acl.h in files that fail to compile.

 --> Jijo

--
Federico Sevilla III  :: jijo@leathercollection.ph
Network Administrator :: The Leather Collection, Inc.
GnuPG Key: <http://jijo.leathercollection.ph/jijo.gpg>

