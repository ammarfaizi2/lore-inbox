Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTLDWFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTLDWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:05:38 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:4224 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263544AbTLDWFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:05:31 -0500
Date: Thu, 4 Dec 2003 17:04:01 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
To: John Stoffel <stoffel@lucent.com>
cc: grundig@teleline.es, Mathieu Chouquet-Stringer <mathieu@newview.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
In-Reply-To: <16335.44623.99755.811085@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.58.0312041702470.27578@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0312041607180.27578@montezuma.fsmlabs.com>
 <16335.44623.99755.811085@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003, John Stoffel wrote:

>
> Zwane> I have a dual PII PW 410 too but with an A10 bios, the attached
> Zwane> config boots on mine. It's beginning to look like an ACPI/bios
> Zwane> revision problem.
>
> I've got the A10 bios as well, and the system boots and works fine
> with 2.4.22 + DM patch.  I don't think there's a newer BIOS available
> either, so that route is out.
>
> I did work on getting this system to boot at one point under the early
> 2.6.0-test series, but it was unstable so I fell back to 2.4.2x and
> I've been there since.
>
> It's also a very upto date Debian unstable/testing system as well.
>
> I've looked at the bugzilla notes, but nothing really pokes out at
> me.  I guess my next test is to try to compile/boot without SMP turned
> on.

That's interesting, that box has been tracking most of 2.5/2.6
development. So far i haven't hit any problems which were specific to it.
This is in a dual cpu configuration. I'd be interested to know whether my
.config boots at all on your system.
