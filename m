Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSHIRr7>; Fri, 9 Aug 2002 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHIRr7>; Fri, 9 Aug 2002 13:47:59 -0400
Received: from e.kth.se ([130.237.48.5]:11793 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S315370AbSHIRr6>;
	Fri, 9 Aug 2002 13:47:58 -0400
To: martin@bruli.net
Cc: o.pitzeier@uptime.at, ghoz@sympatico.ca, france@handhelds.org,
       Jay.Estabrook@compaq.com, pollard@tomcat.admin.navo.hpc.mil,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5.26 - arch/alpha
References: <002b01c23279$84be70a0$1211a8c0@pitzeier.priv.at>
	<3D53AEF8.16231.E49799D@localhost>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 09 Aug 2002 19:51:34 +0200
In-Reply-To: "Martin Brulisauer"'s message of "Fri, 9 Aug 2002 12:00:56 +0200"
Message-ID: <yw1xbs8bgbtl.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Brulisauer" <martin@bruli.net> writes:

> Did anybody use gcc-3.0.x or gcc-3.1? With gcc-3.0.4 I 
> successfully built 2.4.18 but some applications don't run
> correctly (eg. MySQL -> Parser). Is the kernel compilable
> with gcc-3.1? Today I am using gcc-2.95.3 and I think is
> ok; better than egcs (generates less unaligned traps at
> runtime without changing the source).

I've been using gcc 3.1 to compile kernel for a while (since it was
released).  I don't have any problems with 2.4.18 and upward.  I don't
remember which compiler I used previously.

-- 
Måns Rullgård
mru@users.sf.net
