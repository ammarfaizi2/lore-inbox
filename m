Return-Path: <linux-kernel-owner+w=401wt.eu-S1750816AbXAUPdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbXAUPdM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 10:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbXAUPdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 10:33:11 -0500
Received: from zakalwe.fi ([80.83.5.154]:58797 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbXAUPdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 10:33:10 -0500
X-Greylist: delayed 1592 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 10:33:10 EST
Date: Sun, 21 Jan 2007 17:06:18 +0200
From: Heikki Orsila <shdl@zakalwe.fi>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Tony Foiani <tkil@scrye.com>,
       Leon Woestenberg <leon.woestenberg@gmail.com>,
       linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
Message-ID: <20070121150618.GA11613@zakalwe.fi>
References: <7FsPf-51s-9@gated-at.bofh.it> <7FxlV-3sb-1@gated-at.bofh.it> <7FyUF-5XD-21@gated-at.bofh.it> <E1H8a7s-0000at-Jx@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E1H8a7s-0000at-Jx@be1.lrz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 11:40:40AM +0100, Bodo Eggert wrote:
> 1) This change isn't nescensary - any sane person will know that it's not a
>    SI unit. You wouldn't talk about megabananas == 1000000 bananas and
>    expect to be taken seriously.

I've met quite a few non-sane persons then. I find using kilo, mega and 
giga prefixes convenient to use. For example, I often use GEUR to refer 
to Giga Euros, because the word billion is overloaded.

> 2) No sane person would say kibibyte as required by the standard. You'd need
>    a sppech defect in order to do this, and a mental defect in order to try.
>    So why should anybody adhere to the rest of this bullshit?

I think I'm not sane then. I find it easy to use and pronounce.

IEC 60027-2 is a great standard! It removes some annoying ambiquity in 
speech and text. Adhering strictly to proper SI units (k, M, G, ...) 
makes life easier as they are taught in school to everyone.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
