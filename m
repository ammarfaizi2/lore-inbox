Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSBCB5e>; Sat, 2 Feb 2002 20:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBCB50>; Sat, 2 Feb 2002 20:57:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30984 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284305AbSBCB5K>; Sat, 2 Feb 2002 20:57:10 -0500
Message-ID: <3C5C98E6.2090701@zytor.com>
Date: Sat, 02 Feb 2002 17:56:54 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>	<m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com>	<m1665fame3.fsf@frodo.biederman.org> <3C5C54D2.2030700@zytor.com> <m1k7tv8p2z.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> It can be argued that general purpose systems have enough ram that
> putting drivers for all mass produced devices in ram is possible, and
> practical.  But that is a cop out.
> 


Indeed.  Worse, it may not be possible for the *boot medium* to hold all 
those devices...

	-hpa


