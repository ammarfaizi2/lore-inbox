Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbTEOP7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTEOP7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:59:01 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:27553 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264096AbTEOP7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:59:00 -0400
Date: Thu, 15 May 2003 11:34:29 -0400
From: Ben Collins <bcollins@debian.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>, jsimmons@infradead.org
Subject: Re: the incredible disappearing cursor.
Message-ID: <20030515153429.GW433@phunnypharm.org>
References: <20030515152136.GA6724@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515152136.GA6724@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 04:21:36PM +0100, Dave Jones wrote:
> I've seen this happen a few times, and it's starting to
> happen more and more. Boots up, cursor on vesafb is blinking away.
> X starts, flip back to tty1, cursor still there. sometime later
> flip to X, flip to tty again, cursor is invisible.

I've seen the same thing with a mach64. Using a curses app like mutt
brings the cursor back.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
