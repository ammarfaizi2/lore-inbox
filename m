Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbTJ1Nwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 08:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263975AbTJ1Nwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 08:52:44 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:50863 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263972AbTJ1Nwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 08:52:43 -0500
Date: Tue, 28 Oct 2003 08:42:18 -0500
From: Andrew Pimlott <andrew@pimlott.net>
To: linux-kernel@vger.kernel.org, corey@world.std.com, rmk@arm.linuk.org.uk
Subject: Re: PCMCIA (ray_cs) and CONFIG_ISA
Message-ID: <20031028134218.GC5658@pimlott.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, corey@world.std.com,
	rmk@arm.linuk.org.uk
References: <20031028062709.GA5658@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028062709.GA5658@pimlott.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I finally found a simple statement of the problem in the thread
"presario laptop pcmcia loading problems".  In 2.4.23-pre8, I see
some changes to i82365.c, but nothing that would help yenta users.
Is there something in the works?  Would a kconfig workaround be
acceptible?  If so, where should it go, and what
platforms/options/sockets/devices should it depend on?

Andrew
