Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVBOU3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVBOU3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVBOU3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:29:47 -0500
Received: from colin2.muc.de ([193.149.48.15]:44548 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261859AbVBOUOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:14:42 -0500
Date: 15 Feb 2005 21:14:40 +0100
Date: Tue, 15 Feb 2005 21:14:40 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 kernel support MAX memory.
Message-ID: <20050215201440.GA54317@muc.de>
References: <3174569B9743D511922F00A0C943142308085826@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142308085826@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 10:49:05AM -0800, YhLu wrote:
> I got a system with 8 way Opteron. Every CPU has 16G memory.
> 
> 2.6 kernel x86_64, it will crash when it start the Fifth node.

The kernel has been successfully booted on 8 CPU Opteron systems before.
Most likely it is something specific to your system.

-Andi
