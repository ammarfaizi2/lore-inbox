Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbUAFWtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbUAFWtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:49:16 -0500
Received: from [66.35.79.110] ([66.35.79.110]:64655 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265403AbUAFWtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:49:15 -0500
Date: Tue, 6 Jan 2004 14:47:51 -0800
From: Tim Hockin <thockin@hockin.org>
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: thockin@Sun.COM, "H. Peter Anvin" <hpa@zytor.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Message-ID: <20040106224751.GA8672@hockin.org>
References: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 04:28:59PM -0600, Ogden, Aaron A. wrote:
> Solaris there is a command called 'automount' that tells the kernel to
> re-read the automount maps, perhaps it resets the autofs subsystem in
> the kernel as well.  If linux autofs had the same capability we might
> not need the daemon, but until then, having the daemon in userland is a
> good thing.

That's more or less exactly what is proposed.
