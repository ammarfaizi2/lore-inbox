Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSHJCZB>; Fri, 9 Aug 2002 22:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSHJCZB>; Fri, 9 Aug 2002 22:25:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1157 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316548AbSHJCZA>;
	Fri, 9 Aug 2002 22:25:00 -0400
Date: Fri, 09 Aug 2002 19:15:27 -0700 (PDT)
Message-Id: <20020809.191527.78347553.davem@redhat.com>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <9131.1028945953@ocs3.intra.ocs.com.au>
References: <20020809.184104.68900725.davem@redhat.com>
	<9131.1028945953@ocs3.intra.ocs.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Sat, 10 Aug 2002 12:19:13 +1000
   
   Adding a constant prefix to every label and string will increase the
   size of the kernel.

It was just an idea.

I rather don't care how you solve the problem.  What I do care
about is adding garbage like #undef unix to source files, that
part is the bit I find unacceptable.
