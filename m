Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161250AbWGNQd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbWGNQd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWGNQd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:33:56 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:45905 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161250AbWGNQdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:33:55 -0400
Date: Fri, 14 Jul 2006 09:33:51 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       greg@kroah.com, harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-ID: <20060714163351.GA24377@tuatara.stupidest.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org> <20060714154240.GA23480@tuatara.stupidest.org> <44B7C37F.1050400@gentoo.org> <44B7C521.5080009@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B7C521.5080009@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 05:24:01PM +0100, Daniel Drake wrote:

> are XT-PIC). I cannot enable APIC on this system due to buggy BIOS.
                               ^^^^

IO-APIC you mean?

what system have you got there?
