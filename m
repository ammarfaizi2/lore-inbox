Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267194AbTAFWwu>; Mon, 6 Jan 2003 17:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbTAFWwu>; Mon, 6 Jan 2003 17:52:50 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7684 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267194AbTAFWwu>;
	Mon, 6 Jan 2003 17:52:50 -0500
Date: Tue, 7 Jan 2003 00:00:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Power off a SMP Box
Message-ID: <20030106230058.GA372@elf.ucw.cz>
References: <20030102135350.24315441.gigerstyle@gmx.ch> <20030103020358.2c0e6714.sfr@canb.auug.org.au> <20030102164010.5114287b.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102164010.5114287b.gigerstyle@gmx.ch>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Has someone a hint for me?
> > 
> > You could try ACPI in (very) recent kernels.
> 
> You mean a 2.5.x kernel? Any Kernel with the newest ACPI patches has never powered off any of my machines:-(
> Perhaps I don't know something...
> I will try it now again...

You can also get new ACPI for 2.4.X (at acpi.sf.net) and even ACPI in
marcelo's kernel should be good enough for poweroff.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
