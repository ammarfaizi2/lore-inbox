Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTCQF1i>; Mon, 17 Mar 2003 00:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262791AbTCQF1i>; Mon, 17 Mar 2003 00:27:38 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:22264 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S262789AbTCQF1h>; Mon, 17 Mar 2003 00:27:37 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20 instability on bigmem systems?
Date: Sun, 16 Mar 2003 21:38:28 -0800
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <20030317022646.GN20188@holomorphy.com> <200303162059.48245.gregory@castandcrew.com>
In-Reply-To: <200303162059.48245.gregory@castandcrew.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303162138.28608.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 March 2003 20:59, Gregory K. Ruiz-Ade wrote:
> Right now, I'm back to running 2.4.19 with the inode.c patch from one of
> the 2.4.19-preXX-aaY kernels (see
> http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.19/patches) as the
> most stable thing we've gotten so far.

Could you possibly take a look at the kernel BUG that I got Friday night on 
the 2.4.19 kernel, to see if it (oh god please) hopefully points in a 
useful direction?

http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.19

The files are:

burpr-kernel-bug.20030314.2100 (the raw bug)
burpr-kernel-bug.20030314.2100.ksymoops (processed through ksymoops)

FYI, the amaivschk program listed in the BUG is a shell script, and also at 
that URL if you're curious as to what it does.

Thanks again...

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

