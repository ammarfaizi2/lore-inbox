Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314511AbSDXFCQ>; Wed, 24 Apr 2002 01:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314542AbSDXFCP>; Wed, 24 Apr 2002 01:02:15 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:28165 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S314511AbSDXFCM>;
	Wed, 24 Apr 2002 01:02:12 -0400
Date: Wed, 24 Apr 2002 02:01:52 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Hong-Gunn Chew <hgchewML@optusnet.com.au>
Cc: "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>
Subject: Re: File corruption when running VMware.
In-Reply-To: <000201c1eb3f$7e0a8450$241d7f81@hgclaptop>
Message-ID: <Pine.LNX.4.44L.0204240200190.1960-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Hong-Gunn Chew wrote:

> I have a repeatable problem when running VMware workstation 3.00 and
> 3.01.  The cause is still unknown, and could be VMware itself, the
> hardware or the kernel.

If you can reproduce it without VMware or with only the
open source part of VMware (ie without any of the binary
only parts) we might have a chance of debugging it.

If it only happens when you're using the binary only
parts of VMware you're probably better off talking to
the VMware people.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

