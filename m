Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVCPFzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVCPFzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVCPFzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:55:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:37838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262261AbVCPFzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:55:00 -0500
Date: Tue, 15 Mar 2005 21:54:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
Message-Id: <20050315215447.7975a0ff.akpm@osdl.org>
In-Reply-To: <4237C61A.6040501@sbcglobal.net>
References: <4237A5C1.5030709@sbcglobal.net>
	<20050315203914.223771b2.akpm@osdl.org>
	<4237C40C.6090903@sbcglobal.net>
	<20050315213110.75ad9fd5.akpm@osdl.org>
	<4237C61A.6040501@sbcglobal.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert W. Fuller" <orangemagicbus@sbcglobal.net> wrote:
>
> I suppose you have to have your priorities.  It may be old to you, but 
> it's current to me!  That used to be the hallmark of Linux, the fact 
> that it would run on lesser hardware.

Nobody's going to fix that machine while you persist in top-posting ;)

How old is it, anyway?

> Of course, I don't know how well video capture is going to work without 
> the apic programming.  So I guess I'm reduced to rebooting when I want 
> to switch between USB peripherals and video capture?

hm, you didn't mention video capture before.  It should work OK?

Are you running the latest BIOS?

You may be able to set the thing up by hand with the help of
Documentation/i386/IO-APIC.txt.
