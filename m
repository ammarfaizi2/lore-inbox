Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSFSUPU>; Wed, 19 Jun 2002 16:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317996AbSFSUPT>; Wed, 19 Jun 2002 16:15:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60433 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317994AbSFSUPS>;
	Wed, 19 Jun 2002 16:15:18 -0400
Message-ID: <3D10E5FE.A3FA3AEF@zip.com.au>
Date: Wed, 19 Jun 2002 13:13:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Li <chrisl@gnuchina.org>
CC: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
References: <20020619113734.D2658@redhat.com> <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Li wrote:
> 
> ...
> 
> I have a silly question, where is that ext3 CVS? Under sourcefourge
> ext2/ext3 or gkernel?

See http://www.zip.com.au/~akpm/linux/ext3/ - about halfway
down the page.

btw, I merged all the ext3 htree stuff into 2.5.23 yesterday.  Haven't
tested it much at all yet.

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.23/ext3-truncate-fix.patch
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.23/ext3-htree.patch
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.23/htree-fixes.patch

-
