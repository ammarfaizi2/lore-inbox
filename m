Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSAFBTd>; Sat, 5 Jan 2002 20:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSAFBTX>; Sat, 5 Jan 2002 20:19:23 -0500
Received: from ns.suse.de ([213.95.15.193]:6661 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286687AbSAFBTP>;
	Sat, 5 Jan 2002 20:19:15 -0500
Date: Sun, 6 Jan 2002 02:19:14 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <3C376222.8090204@zytor.com>
Message-ID: <Pine.LNX.4.33.0201060218080.29977-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, H. Peter Anvin wrote:

> ... and if you want to see something that's worse than either, check out
> /proc/ide/hda/identify.

AFAIAC, the /proc/ide/ stuff should never have happened.
It's proven that every bit of it can be done in userspace.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

