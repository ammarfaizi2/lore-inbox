Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbVISThf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVISThf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbVISThf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:37:35 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:34029 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S932608AbVISThe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:37:34 -0400
Date: Mon, 19 Sep 2005 21:37:26 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bernd Petrovitsch <bernd@firmix.at>
cc: 7eggert@gmx.de, "Martin v. =?ISO-8859-1?Q?L=F6wis?=" <martin@v.loewis.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
In-Reply-To: <1127077419.8395.35.camel@gimli.at.home>
Message-ID: <Pine.LNX.4.58.0509192132250.2825@be1.lrz>
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it>
  <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it> 
 <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it> 
 <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it> 
 <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it> 
 <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it> 
 <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it> 
 <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it> 
 <E1EH4lL-0001Iz-Lx@be1.lrz> <1127077419.8395.35.camel@gimli.at.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005, Bernd Petrovitsch wrote:
> On Sun, 2005-09-18 at 21:23 +0200, Bodo Eggert wrote:

> > >, etc.). Since the
> > > kernel can start java classes directly, you can probably make a similar
> > > thing for the UTF-8 stuff.
> > 
> > If MSDOS text files are text files are legal scripts, the kernel
> > should recognize [\x0D\x0A] as valid line breaks.
> 
> The Unix worls does recognize the line breaks.

Create a valid text file with macintosh line breaks (as allowed in unicode 
files) and try it.
-- 
If enough data is collected, a board of inquiry can prove ANYTHING. 
