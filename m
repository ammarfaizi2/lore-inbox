Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271634AbRH0A15>; Sun, 26 Aug 2001 20:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271635AbRH0A1r>; Sun, 26 Aug 2001 20:27:47 -0400
Received: from argo.starforce.com ([216.158.56.82]:18816 "EHLO
	argo.starforce.com") by vger.kernel.org with ESMTP
	id <S271634AbRH0A1m>; Sun, 26 Aug 2001 20:27:42 -0400
Date: Sun, 26 Aug 2001 20:28:03 -0400 (EDT)
From: Derek Wildstar <dwild@starforce.com>
To: dman <dsh8290@rit.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs -- where's the M to R?
In-Reply-To: <20010826195651.A5295@hudson>
Message-ID: <Pine.LNX.4.33L2.0108262025590.1097-100000@argo.starforce.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, dman wrote:

> I'm interested in tmpfs for several reasons, one of them is setting up
> a diskless terminal.  I found a few mentions of tmpfs in the FAQ and a
> brief mention in the Multi Disk Tuning HOWTO, but I couldn't find any
> docs on it.  Most of what I read said that there was no tmpfs
> implementation in Linux, but my config (kernel 2.4.8) says there is.
> Any pointers to documentation would be appreciated.

Look at the help for tmpfs in "make menuconfig", if you highlight it then
select "help" ... it explains how to mount it and what some of the options
are.

-dwild

