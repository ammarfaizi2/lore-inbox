Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWAKI1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWAKI1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWAKI1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:27:24 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:56765 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932188AbWAKI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:27:23 -0500
Date: Wed, 11 Jan 2006 03:24:12 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Re: Athlon 64 X2 cpuinfo oddities
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Message-ID: <200601110327_MC3-1-B5A3-6E10@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <9a8748490601100129h2ce343f5kc9bc22885f01831a@mail.gmail.com>

On Tue, 10 Jan 2006, Jesper Juhl wrote:

> Yeah, but since my distro of choice is 32bit only and I don't much
> feel like porting it myself or using an unofficial port (slamd64) I'm
> sticking with a 32bit userspace. And as long as userspace is pure
> 32bit there doesn't seem to be much point in building a 64bit kernel.

 Of course there's a point -- you can test both x86-64 and i386 kernels.
Sometimes one has a bug the other doesn't, as you just found.

 FWIW, 32-bit userspace works almost perfectly for me on 64-bit kernel
(everything but iptables and old pcmcia-cs package.)

-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
