Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291624AbSBAJ0r>; Fri, 1 Feb 2002 04:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291634AbSBAJ0h>; Fri, 1 Feb 2002 04:26:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56330 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291624AbSBAJ0S>; Fri, 1 Feb 2002 04:26:18 -0500
Message-ID: <3C5A5F25.3090101@zytor.com>
Date: Fri, 01 Feb 2002 01:25:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com> <m1r8o5a80f.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> a) More complex.  Just barely.  
> b) Yep.
> c) Yep.
> d) More flexible and can handle what ever it needs to do tomorrow,
>    without mods. 
> 
> All firmware has it's own different format.  With LinuxBIOS things are
> simple enough that you can add a make target instead of having to
> write a specific bootloader to support it.
> 


I cannot agree with you on (d).  In fact, you have already brushed off a 
multiple of issues I have raised, such as interactivity.

I don't particularly care if you want to make this the LinuxBIOS 
platform-specific whatever, but when you start talking about making it 
the grand universal thing, you have me seriously concerned.

	-hpa


