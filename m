Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288897AbSAERen>; Sat, 5 Jan 2002 12:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288894AbSAERed>; Sat, 5 Jan 2002 12:34:33 -0500
Received: from ns.suse.de ([213.95.15.193]:56327 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288897AbSAEReU>;
	Sat, 5 Jan 2002 12:34:20 -0500
Date: Sat, 5 Jan 2002 18:34:18 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <200201051716.g05HGeI125715@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0201051833260.27113-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Albert D. Cahalan wrote:

> Of course, /proc/bus/pci contains forbidden binary files.
> You're supposed to be happy with ASCII text, as found in
> the /proc/pci file.

You miss the point. The point was that /proc/pci doesn't
expose all of pci config space, whereas /proc/bus/pci does.
The fact that it's binary instead of ascii is neither here nor there.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

