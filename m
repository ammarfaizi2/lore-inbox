Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312331AbSDJBQ5>; Tue, 9 Apr 2002 21:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312354AbSDJBQ4>; Tue, 9 Apr 2002 21:16:56 -0400
Received: from tomts17-srv.bellnexxia.net ([209.226.175.71]:10666 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S312331AbSDJBQ4>; Tue, 9 Apr 2002 21:16:56 -0400
Subject: Re: vm-33, strongly recommended [Re: [2.4.17/18pre] VM and swap -
	it's really unusable]
From: shane <shane@zeke.yi.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 09 Apr 2002 21:17:02 -0400
Message-Id: <1018401422.8951.25.camel@mars.goatskin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I too can recommend the -aa kernels. I have been using the -aa kernels
since 2.4.10, and IMHO they are just as stable if not more stable than
the vanilla kernels. The difference is in the performance, especially
the swapping as Andrea noted. Specifically they are better at I/O, both
throughput and interactive responsiveness during heavy I/O. I have also
seen the best utilization on my little 100/switched network using these
kernels. I also use -aa on my Thinkpad and it works great there too. I
haven't tried the XFS but I did try tux and it just smokes!

Anyways just my 2 cents,

Shane

BTW: Big thanks to Andrew Morton for stepping up and splitting the VM
pieces for merging.  




