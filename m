Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbTFBRaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264814AbTFBRaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:30:39 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:17163 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264813AbTFBRaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:30:15 -0400
Date: Mon, 2 Jun 2003 19:43:22 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Josh Litherland <josh@temp123.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Working UP IOAPIC ?
Message-ID: <20030602174322.GA26533@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030602173231.GA10363@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030602173231.GA10363@temp123.org>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Litherland <josh@temp123.org>
Date: Mon, Jun 02, 2003 at 12:32:31PM -0500
> Are there any mainboards for AMD Thoroughbred core on which the UP
> IOAPIC works with Linux?  I've tried several, all have had floods of
> APIC error (02) and (00), and I understand from previous postings that
> this indicates my APIC bus is buggy.
> 
My Epox 8K9A3+ works perfectly with it's APIC, as long as I don't use
ACPI, that is. I'm using a XP2400, this board has a VIA KT400 chipset.

Never seen any APIC errors.

HTH,
Jurriaan
-- 
Be warned that typing \fBkillall \fIname\fP may not have the desired
effect on non-Linux systems, especially when done by a privileged user.
	From the killall manual page
Debian (Unstable) GNU/Linux 2.5.70 4112 bogomips load av: 0.26 0.30 0.12
