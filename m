Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUJASAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUJASAP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUJASAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:00:15 -0400
Received: from brown.brainfood.com ([146.82.138.61]:16002 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S265978AbUJAR7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:59:52 -0400
Date: Fri, 1 Oct 2004 12:59:40 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Arvind Kalyan <arvy@cse.kongu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: OS Virtualization
In-Reply-To: <49219.172.16.42.200.1096629426.kourier@172.16.42.200>
Message-ID: <Pine.LNX.4.58.0410011259250.1236@gradall.private.brainfood.com>
References: <49219.172.16.42.200.1096629426.kourier@172.16.42.200>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004, Arvind Kalyan wrote:

> Hi all,
>
> I'm trying to load and run two linux kernels simultaneously; trying to
> demonstrate virtualization as a first step.
>
>
> Anyone have pointers to where I can start? I looked into plex, bochs,
> vmware, usermode linux.. they only simulate an architecture upon which
> another kernel runs.
>
> My intentions are to give control to both the kernels to directly control
> the hardware and do "context switch" between those two based on
> time-slice.
>
> Thanks in advance.

Search for xenolinux.
