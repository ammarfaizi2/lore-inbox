Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277526AbRJERfu>; Fri, 5 Oct 2001 13:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277527AbRJERfk>; Fri, 5 Oct 2001 13:35:40 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:4366 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S277526AbRJERfg>; Fri, 5 Oct 2001 13:35:36 -0400
Message-Id: <200110051735.f95HZ4ou003296@pincoya.inf.utfsm.cl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Fri, 05 Oct 2001 09:58:04 MST." <Pine.LNX.4.33.0110050952510.1540-100000@penguin.transmeta.com> 
Date: Fri, 05 Oct 2001 13:35:04 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> said:
> On 5 Oct 2001, Eric W. Biederman wrote:

[...]

> > Currently checking to see if the file is executable looks good
> > enough.
> 
> [ executable by the user in question, not just anybody ]
> 
> Yes, I suspect it is.

Who is "user in question"? It is quite legal (if strange) to have a file
user A can modify, but not execute, while B can execute it.
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
