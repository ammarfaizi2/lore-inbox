Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRDWNRN>; Mon, 23 Apr 2001 09:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRDWNRD>; Mon, 23 Apr 2001 09:17:03 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:44490 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id <S132556AbRDWNQ4>;
	Mon, 23 Apr 2001 09:16:56 -0400
Organization: 
Date: Mon, 23 Apr 2001 16:13:47 +0300 (EET DST)
From: mythos <papadako@csd.uoc.gr>
To: <linux-kernel@vger.kernel.org>
Subject: Can't compile 2.4.3 with agcc
Message-ID: <Pine.GSO.4.33.0104231611090.15682-100000@iridanos.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using gcc version pgcc-2.95.3 19991024 (AthlonGCC-0.0.3ex3.1)
I can't compile 2.4.3.I get the follow message:

init/main.o: In function `check_fpu':
init/main.o(.text.init+0x65): undefined reference to
`__buggy_fxsr_alignment'
make: *** [vmlinux] Error 1

Can anyone help me?


