Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266036AbUBQGIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUBQGIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:08:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:41145 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266036AbUBQGHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:07:45 -0500
X-Authenticated: #5429946
From: Felix Seeger <felix.seeger@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
Date: Tue, 17 Feb 2004 07:19:43 +0100
User-Agent: KMail/1.6.1
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402170719.43997.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 04:51, Linus Torvalds wrote:
> Ok,
>  I'm planning on doing the final 2.6.3 tomorrow, so please test this
> final -rc.

Hi

Should NForce2 boards also work without patches and with acpi/apic ?
I saw a change in rc3.

It just hangs again, so I switched back to my patched kernel.
But of course this could be another problem, kernel 2.6.2-rc1 is running very 
stable here with the apictack-rd and the ioapic-rd patches.

thanks
Felix
