Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284843AbRLRTye>; Tue, 18 Dec 2001 14:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284854AbRLRTyT>; Tue, 18 Dec 2001 14:54:19 -0500
Received: from vitelus.com ([64.81.243.207]:42766 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S284843AbRLRTx6>;
	Tue, 18 Dec 2001 14:53:58 -0500
Date: Tue, 18 Dec 2001 11:53:42 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
        James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] DRM OS
Message-ID: <20011218115342.A23308@vitelus.com>
In-Reply-To: <20011214163235.A17636@vitelus.com> <200112181617.fBIGHJQ16815@pinkpanther.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112181617.fBIGHJQ16815@pinkpanther.swansea.linux.org.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 04:17:19PM +0000, Alan Cox wrote:
> encrypted music fed to an encrypted audio controller to speakers which
> decrypt and add watermarks

Write a program that decrypts it. If the speakers can, so can the CPU.
Remeber DeCSS?

> encrypted video decrypted and macrovision + watermarked only in buffers
> the CPU cant access

Again, if weird hardware can decrypt it, so can the CPU. It only takes
one reverse-engineering.

> audio input that has legally mandated watermark checks and wont record
> watermarked data.

I haven't seen any serious watermarks presented.

> That is the dream these people have. They'd also like the OS to scan for
> "illicit" material and phone the law if you do, and to have a mandatory
> remote shutdown of your box

It's scarier than CSS.
