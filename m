Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbTA0Ok3>; Mon, 27 Jan 2003 09:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbTA0Ok2>; Mon, 27 Jan 2003 09:40:28 -0500
Received: from main.gmane.org ([80.91.224.249]:64451 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267199AbTA0Ok1>;
	Mon, 27 Jan 2003 09:40:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: Status of Modules?
Date: Mon, 27 Jan 2003 08:49:43 -0600
Message-ID: <b13gr0$kjg$1@main.gmane.org>
References: <200301270743.15588.emmett@epate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmett Pate wrote:

> What's the status of the module loading code?  I've been compiling them
> into
> the kernel since something around 2.5.3x when the code was rewritten.  I'd
> like to begin using a few modules again (especially some PCMCIA stuff). 
> Is there any documentation explaining what will be necessary for 2.5 to
> use modules?

You need rusty's module-init-tools (packaged in debian at least, probably
elsewhere). Once you have that, the basics at least (ie - everything I've
tried) work fine.

