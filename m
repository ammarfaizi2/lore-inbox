Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269272AbUI3OGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269272AbUI3OGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUI3OGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:06:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48529 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269272AbUI3OGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:06:51 -0400
Date: Wed, 29 Sep 2004 12:44:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Timothy Miller <theosib@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using certain graphics cards on non-x86 systems?
Message-ID: <20040929104405.GH2692@openzaurus.ucw.cz>
References: <20040927160807.80266.qmail@web40708.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927160807.80266.qmail@web40708.mail.yahoo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a quick question.  There are certain devices, like graphics
> cards, which require that their BIOS be run at POST in order to
> initialize certain critical (and often undocumented) bits of their
> hardware before they can be used by the OS.  What does Linux do about
> that on non-x86 systems?  I remember old Alphas had like and 8088
> emulator that allowed SOME PC graphics cards to be used as a console
> even.  But on, say, a G5, are you out of luck?  Is there an x86
> emulator that you use to run the BIOS?  At what stage is it run so that
> you can have a console?  Many cards can't even do basic VGA without the
> BIOS first being run.

Hmm, and when you know how to do this, you'll probably also know how to make
suspend-to-ram...


				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

