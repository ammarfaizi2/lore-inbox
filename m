Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279394AbRKNGGP>; Wed, 14 Nov 2001 01:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280161AbRKNGGF>; Wed, 14 Nov 2001 01:06:05 -0500
Received: from goliath.siemens.de ([194.138.37.131]:6061 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S280154AbRKNGFt>; Wed, 14 Nov 2001 01:05:49 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'Pavel Machek'" <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: RE: STR with APM possible?
Date: Wed, 14 Nov 2001 09:05:30 +0300
Message-ID: <000801c16cd2$5cfde680$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3311
In-Reply-To: <20011113010702.A37@toy.ucw.cz>
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I have ASUS CUSL2 motherboard that supports STR (and it works
perfectly
> > under windows). With the same BIOS settings doing apm --suspend
almost
> > suspends - except that power supply fan continues to run, which
> > indicates, system is not in STR state.
> 
> > Kernel is Mandrake cooker 2.4.13-4mdk (based on -ac6), but it was
true
> > for all kernels I've tried starting from 2.2.19
> >
> > ACPI is not included in mandrake kernels.
> >
> > Is it supported? Anything I can do to debug/fix it?
> 
> ACPI does not yet quite support suspend-to-ram. Wait awhile.
> 

I know that ACPI does not yet work. The question was if it possible with
APM. Obviously it works for many notebooks - because I fail to see how
notebook differs in this respect from desktop, I assume it should work
here as well.

Am I missing something?

-andrej
