Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264966AbSKERje>; Tue, 5 Nov 2002 12:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264970AbSKERjd>; Tue, 5 Nov 2002 12:39:33 -0500
Received: from [212.3.242.3] ([212.3.242.3]:6645 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S264966AbSKERjd>;
	Tue, 5 Nov 2002 12:39:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.44] Poweroff after warm reboot
Date: Tue, 5 Nov 2002 19:46:03 +0100
User-Agent: KMail/1.4.3
References: <200210291031.11837.devilkin-lkml@blindguardian.org> <200210291109.33009.josh@stack.nl> <200210291221.24946.devilkin-lkml@blindguardian.org>
In-Reply-To: <200210291221.24946.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211051946.03641.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 12:21, DevilKin wrote:
> On Tuesday 29 October 2002 11:09, Jos Hulzink wrote:
> > On Tuesday 29 October 2002 10:31, DevilKin wrote:
> > > Hello,
> > >
> > > If I reboot my laptop with kernel 2.5.44 (warm reboot), the machine
> > > reboots, loads the kernel, and then in the middle of the booting
> > > process powers off.
> >
> > Hmm... maybe it has something to do with ACPI ? Could you try booting the
> > kernel after a warm reboot with ACPI disabled ?
>
> It's APM, not ACPI (luckely :oP)

This problem is still present with 2.5.45 and 2.5.46.

DK
-- 
"Kirk to Enterprise -- beam down yeoman Rand and a six-pack."

