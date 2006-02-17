Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWBQTzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWBQTzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWBQTzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:55:24 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:54917 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1751064AbWBQTzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:55:22 -0500
Date: Fri, 17 Feb 2006 14:56:10 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Lz <elezeta@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Problems with sound on latest kernels.
Message-ID: <20060217195610.GC18338@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Lz <elezeta@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com> <1139934640.11659.95.camel@mindpipe> <20060214232222.1016fe87.akpm@osdl.org> <cde01ae70602150542m1b57aa83l62508927276241b@mail.gmail.com> <20060217061701.GA17208@neo.rr.com> <cde01ae70602170831h43668a5ay3a3e4f0ce446c241@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde01ae70602170831h43668a5ay3a3e4f0ce446c241@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 05:31:27PM +0100, Lz wrote:
> Hello, it seems to be fixed at the latests git-.
> 
> Do you still need me to try that patch?

Are you sure you're using the same kconfig options?  For example, is isapnp
now disabled, or are you using the ALSA driver instead of the OSS driver
(appears as "sb" in the kernel log)?

Thanks,
Adam
