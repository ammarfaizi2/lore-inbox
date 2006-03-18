Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWCRTq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWCRTq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 14:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWCRTq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 14:46:29 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:7885 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750821AbWCRTq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 14:46:28 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc6: known regressions (v2)
Date: Sat, 18 Mar 2006 14:46:22 -0500
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "S. Umar" <umar@compsci.cas.vanderbilt.edu>, perex@suse.cz,
       alsa-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <s5hmzfost2h.wl%tiwai@suse.de> <200603181427.14393.kernel-stuff@comcast.net>
In-Reply-To: <200603181427.14393.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603181446.23034.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 14:27, Parag Warudkar wrote:
> On Friday 17 March 2006 15:40, Takashi Iwai wrote:
> > The last patch seems incomplete.  Please try the patch below instead.
> > (This time with a changelog :)
> >
> >
> > Takashi

Additionally I get  azx_get_response timeout in dmesg with the new patch.
Sound works ok despite of that though.

Parag
