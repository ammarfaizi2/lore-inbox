Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289403AbSAJLWx>; Thu, 10 Jan 2002 06:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289401AbSAJLWo>; Thu, 10 Jan 2002 06:22:44 -0500
Received: from ns.suse.de ([213.95.15.193]:18951 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289402AbSAJLWg>;
	Thu, 10 Jan 2002 06:22:36 -0500
Date: Thu, 10 Jan 2002 12:21:41 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <E16OSyI-0002m8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201101221060.12487-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Alan Cox wrote:

> > We have also been over the fact that dmidecode, if written
> > appropriately, could be setuid, or call a "dmicat" setuid program.
> > This is a dmidecode implementation detail.
> We've also proved the DMI data is too unreliable to be used, so the entire
> problem space is irrelevant

That's not a problem, remember Eric volunteered to maintain the
enormous black list 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

