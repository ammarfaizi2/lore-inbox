Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSHBFSe>; Fri, 2 Aug 2002 01:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSHBFSe>; Fri, 2 Aug 2002 01:18:34 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:2546
	"EHLO mythical") by vger.kernel.org with ESMTP id <S318205AbSHBFSd>;
	Fri, 2 Aug 2002 01:18:33 -0400
Date: Fri, 2 Aug 2002 01:21:54 -0400 (EDT)
From: Ryan Anderson <ryan@michonline.com>
To: Alexander Viro <viro@math.psu.edu>
cc: martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
In-Reply-To: <Pine.GSO.4.21.0208011709390.12627-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10208020111410.579-100000@mythical.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2002, Alexander Viro wrote:
> On Thu, 1 Aug 2002, Marcin Dalecki wrote:
> 
> you: "it's easy to screw up when working with ASCII strings"
> me: "tossers will find a way to screw up on anything, no matter what it is;
>      see example of tosser screwing up on plain arithmetics"
> you: "use of ASCII wouldn't help them in that case"

Ages and ages ago (ok, not that long ago, really) I remember reading a
vaguely similar arugment on Fidonet.

The argument was largely over the format of the "next gen" message
format - RFC822 came up a lot, and the ensuing "binary header" vs "ASCII
header" arguments would follow.

All I really learned from that was, "parsing email headers is more 
complicated than people suspect" (binary or ascii, doesn't matter), and that
ASCII has one advantage that more compact/binary/etc formats lack:

When the ASCII file/header/partition table/whatever gets fscked
beyond all recognition, I can fix the goddamn thing with a text editor.

That last part is the reason most people utterly detest things like the
Windows registry and prefer the (imo, at least), much saner /etc design
prevalent in Linux distributions.


--
Ryan Anderson
  sometimes Pug Majere

