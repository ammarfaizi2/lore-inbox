Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRCKXb2>; Sun, 11 Mar 2001 18:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRCKXbT>; Sun, 11 Mar 2001 18:31:19 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:16646 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129259AbRCKXbE>;
	Sun, 11 Mar 2001 18:31:04 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103112330.f2BNUBU163948@saturn.cs.uml.edu>
Subject: Re: Status of posix-ACL's
To: dolze@epcnet.de (Jochen Dolze)
Date: Sun, 11 Mar 2001 18:30:11 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F1457AD86AB6D311A6F200105AD9FB0219E251@EPCNETIN> from "Jochen Dolze" at Mar 07, 2001 05:58:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Dolze writes:

> i found at http://acl.bestbits.at the ACL-linux-project. Now i want to know,
> if there is a plan to integrate posix-ACLs into the fs-part of the kernel,
> e.g. into the VFS-Layer? Is there a general discussion about this anywhere?
> What are the biggest problems? (i know that many userland-tools must be
> changed for this).

I hope not. POSIX ACLs are crap. NFSv4 mostly follows NT.
Compatibility with NFSv4 and SMB (Samba's protocol) is important.

