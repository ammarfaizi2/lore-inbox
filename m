Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSABVOE>; Wed, 2 Jan 2002 16:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284177AbSABVNy>; Wed, 2 Jan 2002 16:13:54 -0500
Received: from ns.suse.de ([213.95.15.193]:25863 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284176AbSABVNu>;
	Wed, 2 Jan 2002 16:13:50 -0500
Date: Wed, 2 Jan 2002 22:13:49 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102154633.A15671@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201022213330.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> That sounds like it might be what I'm after.  My goal is to be able to probe
> the machine and set ISA_CARDS based on the probe.  What's a DMI table and
> how can I query it for the presence of ISA slots?

http://people.redhat.com/arjanv/dmidecode.c

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

