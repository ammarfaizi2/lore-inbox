Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273918AbRJEVIU>; Fri, 5 Oct 2001 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRJEVIL>; Fri, 5 Oct 2001 17:08:11 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:12436 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S273619AbRJEVH6>; Fri, 5 Oct 2001 17:07:58 -0400
Date: Fri, 5 Oct 2001 17:08:22 -0400 (EDT)
From: Alex Larsson <alexl@redhat.com>
X-X-Sender: <alexl@devserv.devel.redhat.com>
To: Pavel Machek <pavel@Elf.ucw.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Directory notification problem
In-Reply-To: <20011005211810.B1272@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0110051708060.19315-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Pavel Machek wrote:

> Hi!
> 
> > I discovered a problem with the dnotify API while fixing a FAM bug today.
> > 
> > The problem occurs when you want to watch a file in a directory, and that 
> > file is changed several times in the same second. When I get the directory 
> 
> Does this mean that we have notification API in Linus' tree?

Yes. since a 2.3.xx somewhere.

/ Alex


