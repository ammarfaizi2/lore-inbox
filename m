Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJF3y>; Wed, 10 Jan 2001 00:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAJF3f>; Wed, 10 Jan 2001 00:29:35 -0500
Received: from [202.169.133.50] ([202.169.133.50]:63990 "EHLO
	mjollnir.rocklines.oyeindia.com") by vger.kernel.org with ESMTP
	id <S129431AbRAJF3c>; Wed, 10 Jan 2001 00:29:32 -0500
Date: Wed, 10 Jan 2001 10:53:52 +0530
From: Suresh Ramasubramanian <mallet@efn.org>
To: linux-india-help@lists.linux-india.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [LIH] Re: PROBLEMS: computer crash due to overfilling ramfs; iso9660 CD not read correctly
Message-ID: <20010110105352.A24711@oyeindia.com>
Mail-Followup-To: linux-india-help@lists.linux-india.org,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200101100501.VAA23068@pl1.hushmail.com> <3A5BF073.2F075978@psynet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5BF073.2F075978@psynet.net>; from devrootp@psynet.net on Wed, Jan 10, 2001 at 10:47:39AM +0530
Organization: Hopelessly Disorganized
X-Operating-System: Linux mjollnir.rocklines.oyeindia.com 2.2.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Archan Paul rearranged electrons thusly:

> I faced the same problem when I patched 2.4.0test7 with reiserFS
> support. On my further correspondence with Alan Cox, he wrote that he is
> unwilling to listen about any "bug report for 2.4kernel", arising after
> patching kernel with some foreign code...
> Any comments? 
 
Simple comment: you misplaced the "quotes".  If you use third party patches
(and reiserfs, though fairly mainstream, _is_ a third party patch), you have to
ask the patch maintainer.  ReiserFS is not (as far as I know) part of the linux
kernel yet.

	--suresh

-- 
Suresh Ramasubramanian  <-->  mallet <at> efn <dot> org
EMail Sturmbannfuhrer, Lower Middle Class Unix Sysadmin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
