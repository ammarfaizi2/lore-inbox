Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUAQCHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUAQCHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:07:10 -0500
Received: from pool-64-223-239-211.port.east.verizon.net ([64.223.239.211]:16855
	"EHLO evilbint.mylan") by vger.kernel.org with ESMTP
	id S265986AbUAQCHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:07:08 -0500
Date: Fri, 16 Jan 2004 21:07:06 -0500
From: Greg Fitzgerald <gregf@bigtimegeeks.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4
Message-ID: <20040117020706.GB5524@evilbint>
References: <20040115225948.6b994a48.akpm@osdl.org> <20040117013115.GA5524@evilbint> <20040117014020.GS1748@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117014020.GS1748@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

	Sorry about the bad description. I have a logitech MX500
mouse that uses the explorer protocol. When i boot -mm4 the
scroll wheel is broke. When you try to scroll with the mouse wheel
the cursor moves all around the screen instead of scrolling. This was fixed
in 2.6.0 by adding psmouse.psmouse_proto=exps to the end of my kernel line in
grub.conf. It also was working in 2.6.1. For some reason it won't in
2.6.1--m4 though. Thanks.

-Greg
