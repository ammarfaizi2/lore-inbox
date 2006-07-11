Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWGKUP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWGKUP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWGKUP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:15:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34065 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750844AbWGKUP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:15:27 -0400
Date: Tue, 11 Jul 2006 21:15:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.18-rc1-mm1 - bad serial port count messages
Message-ID: <20060711201521.GC3677@flint.arm.linux.org.uk>
Mail-Followup-To: John Stoffel <john@stoffel.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <17587.42397.168635.821696@stoffel.org> <20060711185630.GA1240@flint.arm.linux.org.uk> <17588.997.688135.786150@stoffel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17588.997.688135.786150@stoffel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 04:02:45PM -0400, John Stoffel wrote:
> I thought I saw something float by where someone had raised some new
> locking or count variables?  I dunno... I'll work on it tonight and
> see what happens after another reboot.

Those are probably changes in the tty layer - Jon Smirl is attempting
some tty changes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
