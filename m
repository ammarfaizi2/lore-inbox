Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278258AbRJWUp4>; Tue, 23 Oct 2001 16:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278265AbRJWUpr>; Tue, 23 Oct 2001 16:45:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5507 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S278258AbRJWUpj>; Tue, 23 Oct 2001 16:45:39 -0400
Date: Tue, 23 Oct 2001 16:46:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Werner Almesberger <wa@almesberger.net>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <20011023223706.A8463@almesberger.net>
Message-ID: <Pine.LNX.3.95.1011023164253.21024A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Werner Almesberger wrote:

> H. Peter Anvin wrote:
> > The right thing is to get rid of the old initrd compatibility cruft,
> > but that's a 2.5 change.
> 
> Yes, change_root is obsolete (and relies on assumptions that are no
> longer valid in several cases), and there has been plenty of time for
> distributors to switch. An early funeral in 2.5 is a good idea.

Hmm. I need to install a SCSI driver, presumably from initrd
RAM disk as currently works. Will the new pivot-root be transparent?




Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


