Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTAROhW>; Sat, 18 Jan 2003 09:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbTAROhW>; Sat, 18 Jan 2003 09:37:22 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:43916 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264836AbTAROhW>;
	Sat, 18 Jan 2003 09:37:22 -0500
Date: Sat, 18 Jan 2003 15:46:21 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301181446.PAA15406@harpo.it.uu.se>
To: davej@codemonkey.org.uk
Subject: Re: perfctr-2.4.4 released
Cc: linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003 14:33:54 +0000, Dave Jones wrote:
> On Sat, Jan 18, 2003 at 03:31:19PM +0100, Mikael Pettersson wrote:
>  > - Added preliminary support for AMD K8 processors with the
>  >   regular 32-bit x86 kernel. The K8 performance counters appear
>  >   to be identical or very similar to the K7 performance counters.
> 
> Whilst there are some that are the same, there are additionally a
> bunch of new counters. I'll be adding support for these to
> oprofile next week, so keep your eyes open 8-)

Cool! I'll check again next week then.

/Mikael
