Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVBOWUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVBOWUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVBOWUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:20:50 -0500
Received: from mail.tyan.com ([66.122.195.4]:20228 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261916AbVBOWUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:20:46 -0500
Message-ID: <3174569B9743D511922F00A0C943142308085866@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: X86_64 kernel support MAX memory.
Date: Tue, 15 Feb 2005 14:34:17 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If only use 64G RAM, it works well.

YH 

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Tuesday, February 15, 2005 12:15 PM
> To: YhLu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: X86_64 kernel support MAX memory.
> 
> On Tue, Feb 15, 2005 at 10:49:05AM -0800, YhLu wrote:
> > I got a system with 8 way Opteron. Every CPU has 16G memory.
> > 
> > 2.6 kernel x86_64, it will crash when it start the Fifth node.
> 
> The kernel has been successfully booted on 8 CPU Opteron 
> systems before.
> Most likely it is something specific to your system.
> 
> -Andi
> 
