Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbREFCaT>; Sat, 5 May 2001 22:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbREFCaJ>; Sat, 5 May 2001 22:30:09 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:60433 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131481AbREFC3x>;
	Sat, 5 May 2001 22:29:53 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Daniel Podlejski <underley@underley.eu.org>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS and Alan kernel tree 
In-Reply-To: Your message of "Sat, 05 May 2001 23:08:16 +0200."
             <20010505230816.A31544@witch.underley.eu.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 06 May 2001 12:29:46 +1000
Message-ID: <21978.989116186@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 May 2001 23:08:16 +0200, 
Daniel Podlejski <underley@underley.eu.org> wrote:
>I merge XFS witch Alan tree (2.4.4-ac5). It's seems to be stable.
>Patch against Alan tree is avaliable at:
>
>http://www.underley.eu.org/linux/patch.ac-xfs.diff.bz2
>
>It's 1.0 SGI release. Only XFS, pagebuf and POSIX ACLs code, without KDB.

linux-xfs added to cc: list.  Could you try adding
ftp://oss.sgi.com/projects/kdb/download/ix86/kdb-v1.8-2.4.4-ac5.gz
to your patch?

