Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268060AbTBRWXP>; Tue, 18 Feb 2003 17:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268064AbTBRWXP>; Tue, 18 Feb 2003 17:23:15 -0500
Received: from tapu.f00f.org ([202.49.232.129]:24975 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S268060AbTBRWXN>;
	Tue, 18 Feb 2003 17:23:13 -0500
Date: Tue, 18 Feb 2003 14:33:15 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       davej@suse.de, linux@brodo.de
Subject: Re: Select voltage manually in cpufreq
Message-ID: <20030218223315.GA15467@f00f.org>
References: <20030218214220.GA1058@elf.ucw.cz> <20030218214726.GB15007@f00f.org> <20030218215819.GC21974@atrey.karlin.mff.cuni.cz> <20030218220858.GA15273@f00f.org> <20030218221611.D9785@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218221611.D9785@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 10:16:11PM +0000, Russell King wrote:

> User control, yes.  System control can (and should) be fine grained.

Well the issue then is how to avoid making the kernel API extremely
complex and different for every platform out there then?



  --cw
