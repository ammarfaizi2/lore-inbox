Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbTGHXhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbTGHXhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:37:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30481 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265505AbTGHXhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:37:09 -0400
Date: Wed, 9 Jul 2003 00:51:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: James Simmons <jsimmons@infradead.org>, vojtech@suse.cz,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small cleanups for input
Message-ID: <20030709005143.G13083@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	James Simmons <jsimmons@infradead.org>, vojtech@suse.cz,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030624101017.GD159@elf.ucw.cz> <Pine.LNX.4.44.0307082359160.32323-100000@phoenix.infradead.org> <20030708231419.GA619@elf.ucw.cz> <20030709002322.D13083@flint.arm.linux.org.uk> <20030708233247.GA140@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708233247.GA140@elf.ucw.cz>; from pavel@suse.cz on Wed, Jul 09, 2003 at 01:32:48AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 01:32:48AM +0200, Pavel Machek wrote:
> So perhaps we need to add machine_suspend_ram() and
> machine_suspend_disk() to reboot.h? We *do* want to have some generic
> interface...

Sounds good.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

