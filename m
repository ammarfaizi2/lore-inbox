Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbTGVGm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 02:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTGVGm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 02:42:26 -0400
Received: from holomorphy.com ([66.224.33.161]:27037 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269659AbTGVGmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 02:42:25 -0400
Date: Mon, 21 Jul 2003 23:58:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lenar L?hmus <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-mm1 hangs on boot
Message-ID: <20030722065843.GV15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>, linux-kernel@vger.kernel.org
References: <200307220939.14436.lenar@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307220939.14436.lenar@vision.ee>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 09:39:08AM +0300, Lenar L?hmus wrote:
> Hi,
> Wanted to try out 2.6.0-test1-mm1 but no luck.
> The kernel doesn't boot. Right after saying "Ok, booting kernel..."
> it hangs and only hardware reset helps at this point. And yes, I have
> CONFIG_VT_CONSOLE. When vesafb was compiled in it seemed to switch
> screen resolution before hang (vga=791).
> 2.4 boots like a charm.
> It's a KT133A motherboard with 1GB of RAM and 1200MHz AMD CPU.
> I'll attach my .config.
> Any help is appreciated.
> Lenar

I'll try to track some vendor hackers more in tune with the issues of
this model. If I can rule out known issues I'll start looking deeper.


-- wli
