Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbUDSJxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 05:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbUDSJxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 05:53:35 -0400
Received: from [194.89.250.117] ([194.89.250.117]:48256 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S264327AbUDSJxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 05:53:34 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
Date: Mon, 19 Apr 2004 12:53:32 +0300
User-Agent: KMail/1.6.1
References: <Pine.GSO.4.58.0402271451420.11281@stekt37> <Pine.GSO.4.58.0404191124220.21825@stekt37> <20040419015221.07a214b8.akpm@osdl.org>
In-Reply-To: <20040419015221.07a214b8.akpm@osdl.org>
Cc: Tuukka Toivonen <tuukkat@ee.oulu.fi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404191253.32290.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 April 2004 11:52, you wrote:

> > I've seen lots of discussions about different mouse behaviour (or
> > completely non-functioning mouse). If you have one of those problems,
> > this driver should restore the kernel 2.4.x behaviour.
>
> I'd imagine that the input developers would regard that as a step in the
> wrong direction.

Not that I'm the Offical Input Developer(tm) but I'm currently doing 
modifications to the PS/2 mouse support which will hopefully restore full 
functionality for most mice. I'm still coding it and I estimate a day or two 
until I get it working tested patch which I will then send here.

Once question though: I'm currently coding against 2.6.5 - should I do the 
patch against something else?

> Have you sent a report regarding the touchscreen problem?  Is it a
> straightforward bug, or has real functionality been lost?

This wasn't directed to me, but right now I'm focusing on normal mice. I need 
to steal the laptop away from wife to test a Synaptic touchpad....




Kim
