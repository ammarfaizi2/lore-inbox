Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287645AbSBCTkH>; Sun, 3 Feb 2002 14:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287647AbSBCTj5>; Sun, 3 Feb 2002 14:39:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55055 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287645AbSBCTjz>; Sun, 3 Feb 2002 14:39:55 -0500
Message-ID: <3C5D91EB.4000900@zytor.com>
Date: Sun, 03 Feb 2002 11:39:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>	<m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com>	<m1665fame3.fsf@frodo.biederman.org> <3C5C54D2.2030700@zytor.com>	<m1k7tv8p2z.fsf@frodo.biederman.org> <3C5C98E6.2090701@zytor.com> <m1y9ia76f7.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> The simplest is the observation that right now 10MB is about what it
> takes to hold every Linux driver out there.  So all you really need is
> a 16MB system, to avoid a device probing loader.  And probably
> noticeably less than that.  The only systems I see having real
> problems are old systems where device enumeration is not reliable, and
> require human intervention anyway.
> 


A floppy disk is 1.44 MB.

	-hpa

