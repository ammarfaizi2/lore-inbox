Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVEXO4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVEXO4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVEXO4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:56:37 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:53380 "EHLO
	mailwasher.lanl.gov") by vger.kernel.org with ESMTP id S262074AbVEXO4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:56:25 -0400
Date: Tue, 24 May 2005 08:56:16 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: penberg@gmail.com, ericvh@gmail.com, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi
Subject: Re: [V9fs-developer] Re: [RFC][patch 3/7] v9fs: VFS inode operations
 (2.0-rc6)
In-Reply-To: <E1DaaLl-0004Ap-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.58.0505240855310.9339@enigma.lanl.gov>
References: <200505232225.j4NMPmH9014347@ms-smtp-01-eri0.texas.rr.com>
 <84144f0205052401432ffa1075@mail.gmail.com> <Pine.LNX.4.58.0505240803410.9237@enigma.lanl.gov>
 <E1DaaLl-0004Ap-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 May 2005, Miklos Szeredi wrote:

> Why don't you just use 'finish'.  That prints the return value.

assuming gdb, but ok, it's fine by me if them's the rules. 

> Every unnecessary line in a function makes it harder to read.  That
> includes over-commenting and overuse of empty lines.

ok

thanks

ron
