Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSE3Md3>; Thu, 30 May 2002 08:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSE3Md2>; Thu, 30 May 2002 08:33:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18616 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316601AbSE3Md1>;
	Thu, 30 May 2002 08:33:27 -0400
Date: Thu, 30 May 2002 05:17:53 -0700 (PDT)
Message-Id: <20020530.051753.43629018.davem@redhat.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: mathieu@newview.com, andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre9, IDE on Sparc, Big Disks
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.SOL.4.30.0205301424440.2028-100000@mion.elka.pw.edu.pl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
   Date: Thu, 30 May 2002 14:29:13 +0200 (MET DST)
   
   I fixed this endianness mess some time ago, patch is included in 2.5.x
   but for some reason not in 2.4.x, although Andre was informed about
   problem and send patch ...

I encourage you to resubmit this when 2.4.20-preX begins.
2.4.19-preX is a long time going already, no need to delay
it further.  I've sent the simple Sparc fix to Marcelo for
now.
