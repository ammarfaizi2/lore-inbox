Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUAXFpt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 00:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUAXFpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 00:45:49 -0500
Received: from [211.167.76.68] ([211.167.76.68]:61657 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S263539AbUAXFps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 00:45:48 -0500
Date: Sat, 24 Jan 2004 13:40:34 +0800
From: Hugang <hugang@soulinfo.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-Id: <20040124134034.4e9c51e2@localhost>
In-Reply-To: <1074912854.834.61.camel@gaston>
References: <20040119105237.62a43f65@localhost>
	<1074483354.10595.5.camel@gaston>
	<1074489645.2111.8.camel@laptop-linux>
	<1074490463.10595.16.camel@gaston>
	<1074534964.2505.6.camel@laptop-linux>
	<1074549790.10595.55.camel@gaston>
	<20040122211746.3ec1018c@localhost>
	<1074841973.974.217.camel@gaston>
	<20040123183030.02fd16d6@localhost>
	<1074912854.834.61.camel@gaston>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004 13:54:15 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Ok, I hammered that for a day and got pmdisk (patrick's version)
> suspending and resuming on a pismo G3 (with XFree etc.. running). Lots
> of rough edges still (via-pmu sleep need to be improved, ADB need
> porting to the new driver model to be properly suspended/resumed, a
> sysdev for RTC is needed too for time, the asm code should be fixed
> for G5, etc...)

Yes, It works in my laptop too. Cool.

thanks for greate work.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
