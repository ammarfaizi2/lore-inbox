Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293194AbSCJT1S>; Sun, 10 Mar 2002 14:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293190AbSCJT1I>; Sun, 10 Mar 2002 14:27:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54282 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293189AbSCJT05>;
	Sun, 10 Mar 2002 14:26:57 -0500
Message-ID: <3C8BB301.5EC007D5@zip.com.au>
Date: Sun, 10 Mar 2002 11:24:49 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Kirkwood <matthew@hairy.beasts.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: JFS vs gcc 2.95.4
In-Reply-To: <3C8BA70A.206C0EFE@zip.com.au> <Pine.LNX.4.33.0203101914170.3037-100000@sphinx.mythic-beasts.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood wrote:
> 
> On Sun, 10 Mar 2002, Andrew Morton wrote:
> 
> > This worked for me:
> 
> Builds for me, too.  Are you sure that constraint
> isn't useful?

The argument is not referenced in the assembly code.  It seems to be
a cut-n-paste error.

-
