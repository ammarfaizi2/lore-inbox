Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265625AbUABUCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265627AbUABUCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:02:39 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:50770 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S265625AbUABUCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:02:38 -0500
Date: Fri, 2 Jan 2004 22:02:31 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20040102200231.GB11115091@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi> <20031101155604.GB530@alpha.home.local> <20031101182518.GL4640@niksula.cs.hut.fi> <20031101190114.GA936@alpha.home.local> <20040102194200.GA11115091@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102194200.GA11115091@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So this is not a 2.2 kernel issue. I very much doubt it's a kernel issue at
> all. Unless it is a bug in kernel partition detection that is still present
> in 2.4.x.

Short addition: in the earlier thread, it was suggested to inspect the disk
with another OS (DOS, Windows, something else) to rule out Linux kernel
completely. I couldn't easily find anything that boots from cd or preferably
from floppy (since I don't have cdrom attached due to ide cable shortage)
*and* supports the HPT370 ide controller /dev/hdg is connected to.

If I find something that fits the bill, I'll give it a shot.


-- v --

v@iki.fi
