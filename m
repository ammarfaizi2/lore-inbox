Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSEQHML>; Fri, 17 May 2002 03:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315452AbSEQHMK>; Fri, 17 May 2002 03:12:10 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:3976 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S315451AbSEQHMJ>;
	Fri, 17 May 2002 03:12:09 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
From: Kenneth Johansson <ken@canit.se>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3038.1021588938@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 May 2002 09:11:58 +0200
Message-Id: <1021619519.5859.7.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-17 at 00:42, Keith Owens wrote:

> Before I send you the kbuild 2.5 patch, how do you want to handle it?

Why do you not just make a patch the way that makes most sens to you and
sent it to him. 

If you asked me I think it's working so good that you can just rip out
the old one. 


Ps. The only strange thing left that I could find was that I could not
skip the makefile gen when I only wanted to run a config front.

make NO_MAKEFILE_GEN=1 xconfig

