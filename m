Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRCMG5M>; Tue, 13 Mar 2001 01:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130705AbRCMG5D>; Tue, 13 Mar 2001 01:57:03 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:44039 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S130820AbRCMG4v>;
	Tue, 13 Mar 2001 01:56:51 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: make: *** [vmlinux] Error 1
In-Reply-To: <20010311205408.A5102@wioggin.awwgeez>
	<20010312115302.A4210@werewolf.able.es>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 12 Mar 2001 21:07:51 +0100
In-Reply-To: "J . A . Magallon"'s message of "Mon, 12 Mar 2001 11:53:02 +0100"
Message-ID: <m3hf0yn42w.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> writes:

> If you are using pgcc, try getting a real less-buggy compiler, like egcs1.1.2
> or gcc-2.95 (even 2.96 willl work).

... not always. I've had problems with gcc "2.96" from RH-7.0
- the compiler was generating obviously incorrect code in some cases
(and it wasn't .c code fault but a compiler problem).
-- 
Krzysztof Halasa
Network Administrator
