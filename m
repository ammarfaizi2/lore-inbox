Return-Path: <linux-kernel-owner+w=401wt.eu-S1751666AbXAUVa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbXAUVa6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 16:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbXAUVa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 16:30:58 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:50992 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbXAUVa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 16:30:57 -0500
Date: Sun, 21 Jan 2007 22:27:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Heikki Orsila <shdl@zakalwe.fi>
cc: Bodo Eggert <7eggert@gmx.de>, Tony Foiani <tkil@scrye.com>,
       Leon Woestenberg <leon.woestenberg@gmail.com>,
       linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
In-Reply-To: <20070121150618.GA11613@zakalwe.fi>
Message-ID: <Pine.LNX.4.61.0701212223340.29213@yvahk01.tjqt.qr>
References: <7FsPf-51s-9@gated-at.bofh.it> <7FxlV-3sb-1@gated-at.bofh.it>
 <7FyUF-5XD-21@gated-at.bofh.it> <E1H8a7s-0000at-Jx@be1.lrz>
 <20070121150618.GA11613@zakalwe.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 21 2007 17:06, Heikki Orsila wrote:
>
>> 2) No sane person would say kibibyte as required by the standard. You'd need
>>    a sppech defect in order to do this, and a mental defect in order to try.
>>    So why should anybody adhere to the rest of this bullshit?
>
>I think I'm not sane then. I find it easy to use and pronounce.
>
>IEC 60027-2 is a great standard! It removes some annoying ambiquity in 
>speech and text. Adhering strictly to proper SI units (k, M, G, ...) 
>makes life easier as they are taught in school to everyone.

Bleh. Except for storage, base 1024 was used for almost everything
I remember. 4 MB memory meant 4096 KB, and that's still the case today.
Most likely the same for transfer rates.
It's just that storage vendors broke the computer rule and went with 1000.
Just teach all the exceptions. No life is without.


	-`J'
-- 
