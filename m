Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268054AbTBRVhZ>; Tue, 18 Feb 2003 16:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268055AbTBRVhZ>; Tue, 18 Feb 2003 16:37:25 -0500
Received: from tapu.f00f.org ([202.49.232.129]:18063 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S268054AbTBRVhY>;
	Tue, 18 Feb 2003 16:37:24 -0500
Date: Tue, 18 Feb 2003 13:47:26 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, davej@suse.de, linux@brodo.de
Subject: Re: Select voltage manually in cpufreq
Message-ID: <20030218214726.GB15007@f00f.org>
References: <20030218214220.GA1058@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218214220.GA1058@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 10:42:20PM +0100, Pavel Machek wrote:

> I've added possibility to manualy force specified frequency and
> voltage... That's fairly usefull for testing, and I believe this (or
> something equivalent) is needed because every 2nd bios seems to be
> b0rken.

Why are all the power/cpu patches so complex?  Can't we have a
two-mode style operation, "slow-low-power" and "fast-high-power" or
something?  Would that not work with 99% or what people need and also
be somewhat more uniform across platforms, CPUs, etc?


  --cw
