Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWDDMoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWDDMoB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 08:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWDDMoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 08:44:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1805 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932421AbWDDMoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 08:44:00 -0400
Date: Tue, 4 Apr 2006 13:43:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc1: collie -- oopsen in pccardd?
Message-ID: <20060404124350.GA16857@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20060404122212.GG19139@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404122212.GG19139@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 02:22:12PM +0200, Pavel Machek wrote:
> I'm getting some oopses when inserting/removing pccard (on collie,
> oopses in pccardd). It does not break boot, so it is not immediate
> problem, but I wonder if it also happens on non-collie machines?

No idea what so ever.  Not even any clues as to what might be going wrong
due to the lack of oops dump.  (Not that I even look after PCMCIA anymore.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
