Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287394AbRL3Mhs>; Sun, 30 Dec 2001 07:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287395AbRL3Mhj>; Sun, 30 Dec 2001 07:37:39 -0500
Received: from ns.suse.de ([213.95.15.193]:47631 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287394AbRL3Mh2>;
	Sun, 30 Dec 2001 07:37:28 -0500
Date: Sun, 30 Dec 2001 13:37:25 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Lee Packham <lpackham@mswinxp.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.1-dj8 - IDE CD-ROM
In-Reply-To: <000101c1911f$eba8b380$010ba8c0@lee>
Message-ID: <Pine.LNX.4.33.0112301336530.6995-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Lee Packham wrote:

> On a VIA KT266a chipset motherboard with a standard IDE CD-ROM device I
> get input/output errors on all iso9660 + joilet CD's. I don't have any
> basic CDs to try.

Looks like I dropped part of the isofs changes. I'll take a look
at this for the next patch.

Thanks

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

