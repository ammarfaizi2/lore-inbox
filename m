Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSGYMp7>; Thu, 25 Jul 2002 08:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSGYMp7>; Thu, 25 Jul 2002 08:45:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34059 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293680AbSGYMp6>; Thu, 25 Jul 2002 08:45:58 -0400
Date: Thu, 25 Jul 2002 08:43:34 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Olaf Kirch <okir@suse.de>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: Locking patches (generic & nfs)
In-Reply-To: <20020719101950.A15819@suse.de>
Message-ID: <Pine.LNX.3.96.1020725084130.11202B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Olaf Kirch wrote:

> I've been investigating an NFS locking problem a customer
> of SuSE has had between an OpenServer machine (oh boy)
> acting as the NFS client and a Linux box acting as the server.
> 
> In the process of debugging this, I came across a number of
> bugs in the 2.4.18 kernel.

When NFSv4 gets in the new kernel I invite you to put your eyeballs on
that! Good catch!

Clearly not a lot of users go through this code or it would have shown up
sooner.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

