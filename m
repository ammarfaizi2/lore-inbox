Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbREPBfP>; Tue, 15 May 2001 21:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261760AbREPBfF>; Tue, 15 May 2001 21:35:05 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:35325
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S261759AbREPBe7>; Tue, 15 May 2001 21:34:59 -0400
Date: Tue, 15 May 2001 21:34:53 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <01051602593001.00406@starship>
Message-ID: <Pine.LNX.4.33.0105152132580.30128-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 May 2001, Daniel Phillips wrote:

> On Tuesday 15 May 2001 23:20, Nicolas Pitre wrote:
> > Personally, I'd really like to see /dev/ttyS0 be the first detected
> > serial port on a system, /dev/ttyS1 the second, etc.
>
> There are well-defined rules for the first four on PC's.  The ttySx
> better match the labels the OEM put on the box.

Then just make them be detected first.


Nicolas

