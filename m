Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTLDWBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTLDWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:01:44 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:39324 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263609AbTLDWBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:01:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16335.44623.99755.811085@gargle.gargle.HOWL>
Date: Thu, 4 Dec 2003 16:59:43 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: grundig@teleline.es, Mathieu Chouquet-Stringer <mathieu@newview.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
In-Reply-To: <Pine.LNX.4.58.0312041607180.27578@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0312041607180.27578@montezuma.fsmlabs.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zwane> I have a dual PII PW 410 too but with an A10 bios, the attached
Zwane> config boots on mine. It's beginning to look like an ACPI/bios
Zwane> revision problem.

I've got the A10 bios as well, and the system boots and works fine
with 2.4.22 + DM patch.  I don't think there's a newer BIOS available
either, so that route is out.

I did work on getting this system to boot at one point under the early
2.6.0-test series, but it was unstable so I fell back to 2.4.2x and
I've been there since.  

It's also a very upto date Debian unstable/testing system as well.  

I've looked at the bugzilla notes, but nothing really pokes out at
me.  I guess my next test is to try to compile/boot without SMP turned
on.  

John
