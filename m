Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289140AbSA3Ohe>; Wed, 30 Jan 2002 09:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289148AbSA3OhY>; Wed, 30 Jan 2002 09:37:24 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:12813 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289140AbSA3OhR>; Wed, 30 Jan 2002 09:37:17 -0500
Date: Wed, 30 Jan 2002 17:37:15 +0300
From: Oleg Drokin <green@namesys.com>
To: Sebastian Dr?ge <sebastian.droege@gmx.de>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020130173715.B2179@namesys.com>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  Can you please feed this entire oops to a ksymoops?
  Just 2 first entries are not enough.
  Thank you.
  BTW, you are running on a IDE system, right?

Bye,
    Oleg
On Wed, Jan 30, 2002 at 03:14:20PM +0100, Sebastian Dr?ge wrote:
> CPU: 0
> EIP: 0010:[<c0191005>] Not tainted
> EFLAGS: 60010282
> eax: 0000005b ebx: c02b9640 ecx: 00000001 edx: 00000001
> esi: x15a6800 edi: c15a6800 ebp: cdd95e80 esp: cdd95c30
> ds: 0018 es: 0018 ss: 0018
> Process syslogd (pid: 92, stackpage=cdd950000)
> Stack: c02b819a  c0351ba0  c02b9640  cdd95c54  00000000  00000000  c0198065  c15a6800
> 	  c02b9640  cdd95e80  ceece980  00000003  ffffffff  00000001  00001000  00000000
> 	  cdd95ed8  cdd95ed8  000028a3  cdd95c9c  cdd95c98  00000ff8  00000001 00000ff8
> Call Trace: [<c0198065>] [<c0198649>] [<c01893fb>] [<c018a65b>] [<c01335748>] [<c0132378>] [<c010864b>]
> Code: 0f 0b 68 a0 1b 35 c0 b8 a0 81 2b c0 8d 96 cc 00 00 00 85 fb

