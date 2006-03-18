Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWCRT1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWCRT1O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 14:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWCRT1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 14:27:14 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:43712 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750820AbWCRT1O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 14:27:14 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.16-rc6: known regressions (v2)
Date: Sat, 18 Mar 2006 14:27:14 -0500
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "S. Umar" <umar@compsci.cas.vanderbilt.edu>, perex@suse.cz,
       alsa-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <s5h7j6tt4qx.wl%tiwai@suse.de> <s5hmzfost2h.wl%tiwai@suse.de>
In-Reply-To: <s5hmzfost2h.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603181427.14393.kernel-stuff@comcast.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 15:40, Takashi Iwai wrote:
> The last patch seems incomplete.  Please try the patch below instead.
> (This time with a changelog :)
>
>
> Takashi

Sound works with this patch but now only through the head phones - no sound 
from built-in speakers. Jack sense doesn't seem to work the other way around 
- removing head phone doesn't enable speaker output.

Let me know if you need any info.

Thanks!
Parag
