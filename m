Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289708AbSBER70>; Tue, 5 Feb 2002 12:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289725AbSBER7G>; Tue, 5 Feb 2002 12:59:06 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:59654 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289708AbSBER5o>;
	Tue, 5 Feb 2002 12:57:44 -0500
Date: Tue, 5 Feb 2002 13:54:46 +0000
From: Pavel Machek <pavel@suse.cz>
To: Stevie O <stevie@qrpff.net>
Cc: David Woodhouse <dwmw2@infradead.org>, Thomas Hood <jdthood@mail.com>,
        linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: APM and APIC -- multiple batteries (was: apm.c and multiple battery slots)
Message-ID: <20020205135445.C37@toy.ucw.cz>
In-Reply-To: <1012705104.774.4.camel@thanatos> <1012705104.774.4.camel@thanatos> <12638.1012737679@redhat.com> <5.1.0.14.2.20020203203302.00abcec8@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <5.1.0.14.2.20020203203302.00abcec8@whisper.qrpff.net>; from stevie@qrpff.net on Sun, Feb 03, 2002 at 09:55:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> How does the ACPI stuff handle this? *Does* the ACPI stuff handle this 
> (i.e. multiple batteries)?

Yes.

> If so:
>    Is it a generic interface?
>      If so, we should let APM use it too.

Should be generic enough...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

