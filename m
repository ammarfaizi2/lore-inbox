Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272305AbTG3WTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272307AbTG3WTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:19:38 -0400
Received: from [212.97.163.22] ([212.97.163.22]:29433 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S272305AbTG3WTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:19:37 -0400
Date: Thu, 31 Jul 2003 00:19:25 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730221925.GA2858@werewolf.able.es>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030730203318.GH1873@lug-owl.de>; from jbglaw@lug-owl.de on Wed, Jul 30, 2003 at 22:33:18 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.30, Jan-Benedict Glaw wrote:
[...]
> 
> ...and IFF those new opcodes bring _that_ much performance, then we
> should think about another Debian distribution for i686-linux. Up to
> now, I was really proud of having _one_ distribution that's basically
> capable of running on all and any machines I own...
> 

Do as Mandrake (and I suppose another distros), and put optimized libraries
in /lib/i686, /lib/mmx, /lib/sse, /usr/lib/i686, etc. New ld.so supports
mapping different versions of library depending on arch.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like
sex:
werewolf.able.es                         \           It's better when it's
free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre9-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.7mdk))
