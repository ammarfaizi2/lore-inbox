Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268481AbTBOAmp>; Fri, 14 Feb 2003 19:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268482AbTBOAmp>; Fri, 14 Feb 2003 19:42:45 -0500
Received: from main.gmane.org ([80.91.224.249]:58280 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S268481AbTBOAmn>;
	Fri, 14 Feb 2003 19:42:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Wuertele <dave-gnus@bfnet.com>
Subject: how to interactively break gdb debugging kernel over serial?
Date: Fri, 14 Feb 2003 15:54:47 -0800
Organization: Berkeley Fluent Network
Message-ID: <m38ywia054.fsf@bfnet.com>
References: <20030214234557.GC13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2 (i686-pc-linux-gnu)
Cancel-Lock: sha1:3hTT5qL31tcZDUFzMjiOgXjOSrY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm debugging the kernel with gdb over a serial port.  Breakpoints and
stepping through code works great, except for the fact that once the
kernel is running, I can't seem to use Control-C to stop it.  Is there
a keypress or other interactive way to break a running kernel?

Thanks,
Dave

