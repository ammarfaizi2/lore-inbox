Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287023AbSABWNo>; Wed, 2 Jan 2002 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287022AbSABWNf>; Wed, 2 Jan 2002 17:13:35 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:5045 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S287037AbSABWNW>; Wed, 2 Jan 2002 17:13:22 -0500
Message-ID: <3C338600.B019EED9@sympatico.ca>
Date: Wed, 02 Jan 2002 17:13:20 -0500
From: Chris Friesen <chris_friesen@sympatico.ca>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

That's just the point!  The hardware manufacturers are going to implement the
crypto so that only valid digitally signed files can be played on that hardware,
and there will be crypto at every step to try and prevent people from getting at
the unencrypted bytestream.

They want to keep us from doing cd/mp3 or DVD/DivX type conversions.

Chris
