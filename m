Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUJNNrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUJNNrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUJNNrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:47:31 -0400
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:36485
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S264980AbUJNNrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:47:24 -0400
Date: Thu, 14 Oct 2004 09:46:57 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>,
       Hirokazu Takata <takata.hirokazu@renesas.com>, jgarzik@pobox.com,
       takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       paul.mundt@nokia.com, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
In-Reply-To: <20041014113044.A5076@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0410140946340.17226@xanadu.home>
References: <416BFD79.1010306@pobox.com> <20041013.105243.511706221.takata.hirokazu@renesas.com>
 <416C8E0B.4030409@pobox.com> <20041013.121547.863739114.takata.hirokazu@renesas.com>
 <20041012223227.45a62301.akpm@osdl.org> <20041014113044.A5076@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Russell King wrote:

> On Tue, Oct 12, 2004 at 10:32:27PM -0700, Andrew Morton wrote:
> > smc91x-assorted-minor-cleanups.patch
> 
> This patch removes a comment I added to satisfy Jeff's review which
> explains how the link state is initialised - it probably isn't a good
> idea to remove this.

It was just moved elsewhere.


Nicolas
