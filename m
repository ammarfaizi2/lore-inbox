Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284280AbSABVX4>; Wed, 2 Jan 2002 16:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284866AbSABVW5>; Wed, 2 Jan 2002 16:22:57 -0500
Received: from ns.suse.de ([213.95.15.193]:62215 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284763AbSABVWS>;
	Wed, 2 Jan 2002 16:22:18 -0500
Date: Wed, 2 Jan 2002 22:22:17 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Bill Nottingham <notting@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102162349.A957@apone.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0201022219270.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Bill Nottingham wrote:

> > And newer ones. I've seen 'Full length ISA slot' reported on a laptop
> > for eg.
> I have an ia64 here that, according to dmidecode, has a
> 32bit NUBUS slot in it. AFAIK, that's not the case. ;)

*grin*, for some things, DMI is reliable, others its down to whether
individual bios vendors decide to add the relevant strings.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

