Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTJ1FC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 00:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTJ1FCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 00:02:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31748 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263855AbTJ1FCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 00:02:54 -0500
Date: Mon, 27 Oct 2003 23:52:42 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test9
In-Reply-To: <3F9DD0A6.1010703@pobox.com>
Message-ID: <Pine.LNX.3.96.1031027234844.23915A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Jeff Garzik wrote:

> bill davidsen wrote:
> > In article <20031027182141.GH32168@vic20.blipp.com>,
> > Patrik Wallstrom  <pawal@blipp.com> wrote:
> > 
> > | This patch worked for the Promise-controller:
> > | http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-promise20378.patch
> > 
> > If this patch solves the problem, might I hope that it will be
> > considered critical enough a bugfix to get into the mainline? I assume
> > the SATA code added in test9 was intended to work, rather than as a
> > place holder.
> 
> 
> The above patch solves the 'problem' of a particular PCI id not being 
> listed in the driver.
> 
> IOW it _adds_ new hardware support.

Sounds unlikely to be considered a fix for a major problem. Thanks for the
info. Also sounds unlikely to be a fix for any similar problem :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

