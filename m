Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbSIZSLq>; Thu, 26 Sep 2002 14:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261428AbSIZSLq>; Thu, 26 Sep 2002 14:11:46 -0400
Received: from jdike.solana.com ([198.99.130.100]:2432 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S261421AbSIZSLp>;
	Thu, 26 Sep 2002 14:11:45 -0400
Message-Id: <200209261819.g8QIJN701373@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Shanti Katta <katta@csee.wvu.edu>
cc: Ben Collins <bcollins@debian.org>, sparc-linux@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Reg Sparc memory addresses 
In-Reply-To: Your message of "26 Sep 2002 13:54:57 EDT."
             <1033062898.2037.43.camel@indus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 Sep 2002 14:19:23 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

katta@csee.wvu.edu said:
> So, I guess I need to compile UML as "sparc" target and debug it. I am
> not sure how much of UML code runs in kernelspace

None of it does.  That's sort of the point of UML.

				Jeff

