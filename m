Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUAMDn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 22:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUAMDn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 22:43:26 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:38577 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263166AbUAMDnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 22:43:24 -0500
Date: Mon, 12 Jan 2004 21:47:08 -0500
From: Ben Collins <bcollins@debian.org>
To: "Chris K. Engel" <morbie@legions.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun Type5 Mapping 2.4 -> 2.6
Message-ID: <20040113024708.GZ31486@phunnypharm.org>
References: <Pine.LNX.4.56.0401121950030.18099@cyberspace7.legions.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401121950030.18099@cyberspace7.legions.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 07:54:02PM -0600, Chris K. Engel wrote:
> I've noticed something strange.
> When updating to 2.6.1, my type5's mapping was really, really set off.
> Nothing would work, period. (And I've noticed an abundance of mapping
> issues on non-US keyboard layouts.)

Everything in 2.6 is an i386 key mapping. Switch your console key
mapping to an i386 type, or just plain old disable the console key
mapping and leave it up to the kernel (which is what I do).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
