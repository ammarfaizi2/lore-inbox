Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267382AbRGLAYx>; Wed, 11 Jul 2001 20:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbRGLAYn>; Wed, 11 Jul 2001 20:24:43 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:33284
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S267382AbRGLAY1>; Wed, 11 Jul 2001 20:24:27 -0400
Date: Wed, 11 Jul 2001 20:23:50 -0400
From: Chris Mason <mason@suse.com>
To: Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <293480000.994897430@tiny>
In-Reply-To: <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, July 11, 2001 04:03:09 PM -0700 Lance Larsh
<llarsh@oracle.com> wrote:

> I ran lots of iozone tests which illustrated a huge difference in write
> throughput between reiser and ext2.  Chris Mason sent me a patch which
> improved the reiser case (removing an unnecessary commit), but it was
> still noticeably slower than ext2.  Therefore I would recommend that
> at this time reiser should not be used for Oracle database files.
> 

Hi Lance,

Could I get a copy of the results from last benchmark you ran (with the
patch + noatime on reiserfs).  I'd like to close that gap...

-chris

