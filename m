Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTEJPmL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTEJPmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:42:11 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:24749 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264405AbTEJPmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:42:09 -0400
Date: Sat, 10 May 2003 11:52:39 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <20030510154639.02DDC32C9@marauder.googgun.com>
Message-ID: <Pine.LNX.4.33.0305101150420.24272-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 May 2003, Tuncer M zayamut Ayaz wrote:

> On Sat, 10 May 2003 11:39:12 -0400 (EDT)
> Ahmed Masud <masud@googgun.com> wrote:
>
> can't say whether there is an internal speaker it could come
> from. source of sound is right beneath the keyboard,
> and creating load aka moving an x11 window around produces
> funny patterns --> no high tone, it almost disappears,
> but just low-volume sound reacting to when I move the
> window around.
> for a non-hardware-expert this is strange stuff.
>

I think your keyboard may have a stuck key *grin*.

Suggest the following:

1. remove keyboard from computer, to see if that stops the sound.
2. remove mouse from computer to see if that stops the sound. (ps/2 mice
can be silly)

if neither then we can say you have an odd bug.

Ahmed.

