Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTI2PYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTI2PYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:24:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:8953 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263573AbTI2PY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:24:28 -0400
Date: Mon, 29 Sep 2003 16:24:01 +0100
From: Dave Jones <davej@redhat.com>
To: Dennis Grant <trog@wincom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does AGP 8X work in 2.4.x yet?
Message-ID: <20030929152401.GA11108@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dennis Grant <trog@wincom.net>, linux-kernel@vger.kernel.org
References: <3f78415a.43a8.0@wincom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f78415a.43a8.0@wincom.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 10:34:51AM -0400, Dennis Grant wrote:
 > Sorry for butting in, but I've been trying to find the answer to this question
 > through other means without much success.
 > 
 > I have an Asus A7V8X motherboard (VIA Athlon chipset, 333Mhz FSB) with an AGP
 > 8X slot on it.
 > 
 > I'm currently running an NVidia GeForce MX400 PCI video card, using the NVidia
 > binary drivers, and everything works fine. Kernel version 2.4.20.
 > 
 > I'm considering picking up an NVidia GeForce 5200 AGP 8X card, but I had heard
 > through the grapevine that 2.4.x did not support AGP 8X cards yet - waiting
 > on a backport from 2.5?
 > 
 > Perhaps I'm mistaken. Anyway, does 2.4.x work with AGP 8X?

No. However NVIDIA's binary drivers may or may not do their own AGPx8 support.
Usual caveats apply to using those drivers however..

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
