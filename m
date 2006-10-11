Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030775AbWJKEBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030775AbWJKEBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 00:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030785AbWJKEBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 00:01:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030775AbWJKEBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 00:01:39 -0400
Date: Tue, 10 Oct 2006 21:01:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
Message-Id: <20061010210133.dda19d4c.akpm@osdl.org>
In-Reply-To: <452C616D.7040701@us.ibm.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<452C616D.7040701@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 20:13:49 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> >
> >
> > - Added the ext4 filesystem.  Quick usage instructions:
> >
> >   - Grab updated e2fsprogs from
> >     ftp://ftp.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs-interim/
> >   
> 
> Hi Ted,
> 
> e2fsprogs-1.39-tyt1-rollup.patch doesn't compile. (seems to be missing 
> percent.c). Can
> you role up new version ? I had to apply individual patches to get it 
> working ..
> 

http://userweb.kernel.org/~akpm/e2fsprogs-akpm.tar.gz is the version I
used.  That's e2fsprogs-1.39 plus patches from
http://www.bullopensource.org/ext4/20060926/
