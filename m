Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285022AbRLQGKJ>; Mon, 17 Dec 2001 01:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbRLQGJ7>; Mon, 17 Dec 2001 01:09:59 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:36482 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S285022AbRLQGJr>; Mon, 17 Dec 2001 01:09:47 -0500
Message-ID: <3C1D8C70.A6811F@mcn.net>
Date: Sun, 16 Dec 2001 23:10:56 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] DRM OS
In-Reply-To: <Pine.LNX.4.10.10112121959320.8479-100000@www.transvirtual.com> <Pine.LNX.4.10.10112140107130.8630-100000@master.linux-ide.org> <20011214163235.A17636@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> 
> On Fri, Dec 14, 2001 at 01:15:48AM -0800, Andre Hedrick wrote:
> > CPU(crypto)<->Memory(crypto)<->Framebuffer(crypto)
> > ata(clean)<->diskcontroller(crypto)<->Memory(crypto)<->CPU(crypto)
> > scsi(crypto)<->diskcontroller(crypto)<->Memory(crypto)<->CPU(crypto)
> > CPU(crypto)<->Bridge(crypto)<->Memory(crypto)
> >
> > Just watch and see!
> 
> Why would crypto help at all?
> -

To prevent us from sniffing the bus to figure out proprietary protocols
like we do with USB devices.  ...and other things, of course.

-- 
===============
-- TimO
--------------------==============++==============--------------------
                             No Cool .sig
