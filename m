Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSDEJFh>; Fri, 5 Apr 2002 04:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312413AbSDEJF1>; Fri, 5 Apr 2002 04:05:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17207 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312411AbSDEJFN>; Fri, 5 Apr 2002 04:05:13 -0500
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org> <20020405080115.GA409@ucw.cz>
	<m1k7rmpmyq.fsf@frodo.biederman.org> <20020405084733.GG609@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2002 01:58:41 -0700
Message-ID: <m1g02aplmm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> writes:

> Hello!
> 
> > The fact that you can't treat the generated .o as a normal object
> > is simply a maintenance nightmare.
> 
> Why? You can easily convert it to a normal absolute .o file by objcopy.
> 
> Also, I think you could do the same in the linker script.

Show me a linker script that can link together bootsect.o and bsetup.o.

Eric
