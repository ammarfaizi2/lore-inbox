Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUJASBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUJASBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUJASBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:01:13 -0400
Received: from brown.brainfood.com ([146.82.138.61]:18050 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S265795AbUJASAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:00:35 -0400
Date: Fri, 1 Oct 2004 13:00:18 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Martin Waitz <tali@admingilde.org>
cc: Arvind Kalyan <arvy@cse.kongu.edu>, linux-kernel@vger.kernel.org
Subject: Re: OS Virtualization
In-Reply-To: <20041001123712.GD4072@admingilde.org>
Message-ID: <Pine.LNX.4.58.0410011300020.1236@gradall.private.brainfood.com>
References: <49219.172.16.42.200.1096629426.kourier@172.16.42.200>
 <20041001123712.GD4072@admingilde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004, Martin Waitz wrote:

> hi :)
>
> On Fri, Oct 01, 2004 at 04:47:06PM +0530, Arvind Kalyan wrote:
> > My intentions are to give control to both the kernels to directly control
> > the hardware and do "context switch" between those two based on
> > time-slice.
>
> Have a look at Xen: http://www.cl.cam.ac.uk/Research/SRG/netos/xen/
> They don't really allow direct hardware manipulation but use drivers
> of their own.

For 2.0, they allow direct hardware manipulation.
