Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbTATNYp>; Mon, 20 Jan 2003 08:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbTATNYp>; Mon, 20 Jan 2003 08:24:45 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:52627 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S265798AbTATNYo>; Mon, 20 Jan 2003 08:24:44 -0500
Message-ID: <7284135.1043069329179.JavaMail.nobody@web55.us.oracle.com>
Date: Mon, 20 Jan 2003 05:28:49 -0800 (PST)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: davej@codemonkey.org.uk
Subject: Re: "Latitude with broken BIOS" ?
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Mon, Jan 20, 2003 at 04:31:58AM -0800, Alessandro Suardi wrote:
>  >   I was hoping to use HT on my new Latitude C640 (P4 @ 1.8Ghz) but at boot
>  >   both 2.4.21-pre3 and 2.5.59 (obviously with a SMP kernel) tell me
>
> I'd be surprised^Wamazed if your laptop has HT. AFAIK, no-one is
> shipping such a system yet. Just because the CPU flags say 'ht' does
> not mean it has >1 CPU thread per CPU package.

I'd imagined this - but digging on the Intel website I couldn't find anything
 that told me "the mobile P4 can't do HT, period". As a matter of fact not
 even win2k (I'm dualbooting waiting to install Debian and RHAS...) sees
 the system as a 2-CPU.

>  >  "Dell Latitude with broken BIOS detected. Refusing to enable the local APIC."
>
> Lots of Dell laptops (like other vendors) crash instantly when trying to
> enable the APIC.

Well my Dells power off on rebooting from 2.5... bug 119 or 134 in
 http://bugme.osdl.org, no need to resort to messing with the APIC ;(

>  >  Is this anything that can be played with ?
>
> Nope.

Oh, okay. Giving up on this one...

Thanks for the quick reply ! Ciao,

--alessandro
