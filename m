Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSDUKkA>; Sun, 21 Apr 2002 06:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311403AbSDUKj7>; Sun, 21 Apr 2002 06:39:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62667 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310917AbSDUKj6>;
	Sun, 21 Apr 2002 06:39:58 -0400
Date: Sun, 21 Apr 2002 03:31:02 -0700 (PDT)
Message-Id: <20020421.033102.36599175.davem@redhat.com>
To: urban@teststation.com
Cc: linux-kernel@vger.kernel.org, jj@sunsite.ms.mff.cuni.cz, davidm@hpl.hp.com,
        schwidefsky@de.ibm.com, engebret@us.ibm.com, vandrove@vc.cvut.cz
Subject: Re: [patch] 64bit archs doing incorrect magic for smbfs?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0204211221400.13036-100000@cola.teststation.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Urban Widmark <urban@teststation.com>
   Date: Sun, 21 Apr 2002 12:37:04 +0200 (CEST)
   
   Untested patch vs 2.4.19-pre7-ac2 below adds version number checks for the
   smbfs case (yes, it handles the ascii format too). Similar changes are
   needed in 2.5.

I have no problems with this fix, you know the internals better
than me.
