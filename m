Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290961AbSAaFuv>; Thu, 31 Jan 2002 00:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSAaFum>; Thu, 31 Jan 2002 00:50:42 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:33040 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290957AbSAaFu1>; Thu, 31 Jan 2002 00:50:27 -0500
Date: Wed, 30 Jan 2002 20:56:25 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: fonts corruption with 3dfx drm module
Message-ID: <20020130195625.GA21521@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <3C584532.3B64FBC@astercity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C584532.3B64FBC@astercity.net>
User-Agent: Mutt/1.3.25i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:10:42PM +0100, Marek Kassur wrote:
> Zwane Mwaikambo ask me to post to kernel list directly, so here it is.
> 
> I have Voodoo 3 3000 PCI on dual pentium 200MHz (MMX) so no MTRR here
> and I see occasionally font corruption with every Xfree 4.x (excluding
> 4.2, because don't have it yet). I use only text console. Typically one
> or sometimes more characters are corrupted and look like upper/lower
> fragment is eaten. Always switch to X and back correct it.
> 
In that case, let me pitch in and say I never saw any corruption.

Voodoo 4500 pci
X 4.1.x
framebuffer 1600x1200-16@86
Alpha 21164 computer.
mtrr? none on Alpha :-)

Jurriaan
-- 
5) "My competition did it!"  Tactics for showing how the spam that
points to your site (and got you 12 orders) was actually an attempt by
your competition to malign you.
	'Top ten seminars at an upcoming DMA conference' as seen in nanae
GNU/Linux 2.4.18p7-rmap12a on Debian/Alpha 988 bogomips load:0.04 0.03 0.00
