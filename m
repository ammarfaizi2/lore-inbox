Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTJGSfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbTJGSfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:35:46 -0400
Received: from rei.purplehat.net ([216.234.116.164]:24297 "EHLO
	rei.purplehat.net") by vger.kernel.org with ESMTP id S262665AbTJGSfp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:35:45 -0400
Subject: Re: More 2.6.0-test6 PCMCIA and Orinoco problems
From: "Joshua M. Thompson" <funaho@jurai.org>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1065549318.4323.9.camel@athena.fprintf.net>
References: <1065540880.1415.22.camel@lumiere.jurai.org>
	 <1065549318.4323.9.camel@athena.fprintf.net>
Content-Type: text/plain
Organization: Planet Jurai
Message-Id: <1065551689.1415.24.camel@lumiere.jurai.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Oct 2003 14:34:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-07 at 13:55, Daniel Gryniewicz wrote:

> Is this the in-kernel driver or the one from pcmcia-cs?  I use the
> in-kernel driver and pcmcia socket driver (yenta), and just use the
> userspace tools from pcmcia-cs, and everything is good for me.  I never
> was able to get a pure pcmcia-cs (userspace and drivers) working with my
> 2.6.0-test1 kernels when I tried it.

Yes it's the in-kernel driver (yenta_socket.ko etc) and the userspace
tools.

-- 
Joshua M. Thompson <funaho@jurai.org>
Planet Jurai

