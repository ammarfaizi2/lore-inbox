Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281096AbRKEM3A>; Mon, 5 Nov 2001 07:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281098AbRKEM2k>; Mon, 5 Nov 2001 07:28:40 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:6419 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281096AbRKEM2d>; Mon, 5 Nov 2001 07:28:33 -0500
Date: Mon, 5 Nov 2001 13:28:31 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011105132831.C5805@emma1.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011104193232.A16679@mikef-linux.matchmail.com> <200111050554.fA55swt273156@saturn.cs.uml.edu> <3BE647F4.AD576FF2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov 2001, Andrew Morton wrote:

> OK.  I'm not really aware of a suitable benchmark for that.
> postmark only works in a single directory.  mongo hardly
> touches the disk at all, (with 3/4 of a gig of RAM, anyway).

You can always pass the kernel "mem=64M".

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
