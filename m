Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSD0UEI>; Sat, 27 Apr 2002 16:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSD0UEH>; Sat, 27 Apr 2002 16:04:07 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:43187 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S314444AbSD0UEG>;
	Sat, 27 Apr 2002 16:04:06 -0400
Date: Sat, 27 Apr 2002 21:03:50 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Matthew M <matthew.macleod@btinternet.com>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simon@veritas.com>
Subject: Re: Microcode update driver
In-Reply-To: <m171Yag-000Ga6C@Wasteland>
Message-ID: <Pine.LNX.4.33.0204272101260.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002, Matthew M wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Saturday 27 April 2002 7:57 pm, Roy Sigurd Karlsbakk wrote:
> > Sorry if this is a FAQ, but where's the microcode.dat supposed to be
> > placed? I can't find any information about that in the doc.
>
> /usr/share/misc/microcode.dat
>

You could have asked the author of the driver (myself) or the author of
microcode_ctl (Simon Trimmer) before giving your "authoritative" answer :)

The default location is /etc/microcode.dat but distributions are free to
put it anywhere they like, e.g. Red Hat puts it in
/etc/firmware/microcode.dat

Regards
Tigran


