Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWEQATJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWEQATJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWEQATI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:19:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:14532 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932375AbWEQASk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:18:40 -0400
X-Authenticated: #20559227
Date: Wed, 17 May 2006 02:20:57 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Junichi Uekawa <dancer@netfort.gr.jp>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
Subject: Re: ppc: bogomips at 73 when CPU is at 1GHz
Message-ID: <20060517002057.GA6411@localhost>
References: <87ac9hzn1g.dancerj%dancer@netfort.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ac9hzn1g.dancerj%dancer@netfort.gr.jp>
X-Spoken-Languages: en, de
X-URL: http://www.wolfgangpfeiffer.com
User-Agent: Mutt/1.5.11+cvs20060126
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 06:18:19AM +0900, Junichi Uekawa wrote:
> Hi,
> 
> I've noticed the very log value on bogomips on self-compiled 2.6.16.16
> on iBook G4.
> 
> [06:12:59]ibookg4:~> cat /proc/cpuinfo
> processor       : 0
> cpu             : 7447A, altivec supported
> clock           : 1066.666000MHz
> revision        : 0.1 (pvr 8003 0101)
> bogomips        : 73.47
> timebase        : 18432000
> machine         : PowerBook6,5
> motherboard     : PowerBook6,5 MacRISC3 Power Macintosh
> detected as     : 287 (iBook G4)
> pmac flags      : 0000001b
> L2 cache        : 512K unified
> pmac-generation : NewWorld
> 
> 
> It was somewhat higher on 2.6.14.

Nothing to be worried about, as it seems:

http://lists.debian.org/debian-powerpc/2006/03/msg00085.html
http://lists.debian.org/debian-powerpc/2006/04/msg00126.html


HTH

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
