Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSIXJVk>; Tue, 24 Sep 2002 05:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSIXJVk>; Tue, 24 Sep 2002 05:21:40 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:34461 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261323AbSIXJVj>;
	Tue, 24 Sep 2002 05:21:39 -0400
Message-ID: <1032859610.3d902fda0c16a@kolivas.net>
Date: Tue, 24 Sep 2002 19:26:50 +1000
From: Con Kolivas <conman@kolivas.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.4.33.0209232236070.27095-100000@coffee.psychology.mcmaster.ca> <1032835551.3d8fd1df2fba0@kolivas.net> <3D8FD580.F1320237@digeo.com> <200209240850.g8O8odp24965@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200209240850.g8O8odp24965@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>:

> On 24 September 2002 01:01, Andrew Morton wrote:
> > (And if there's more than a 1% variation between same kernel, compiled
> > with different compilers then the test is bust.  Kernel CPU time is
> > dominated by cache misses and runtime is dominated by IO wait.
> > Quality of code generation is of tiny significance)
> 
> Well, not exactly. If it is true that Intel/MS compilers beat GCC
> by 30% on code size, 30% smaller kernel ought to make some difference.
> 
> However, that will become a GCC code quality benchmark then.

Great well if someone has access to one of these compilers and can successfully
compile me a kernel using my .config I'd love to benchmark it for them.

Con.
