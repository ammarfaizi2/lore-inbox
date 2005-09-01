Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVIAHpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVIAHpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVIAHpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:45:43 -0400
Received: from styx.suse.cz ([82.119.242.94]:51894 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S965077AbVIAHpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:45:42 -0400
Date: Thu, 1 Sep 2005 09:45:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
Message-ID: <20050901074556.GA8143@midnight.suse.cz>
References: <E1EAd1J-0007Cw-00@calista.eckenfels.6bone.ka-ip.net> <431651BC.9020108@utah-nac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431651BC.9020108@utah-nac.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 06:56:28PM -0600, jmerkey wrote:

> Bernd,
> 
> Thanks for the accurate and reasonable response.  I object to the use
> of the word "tainted".  This implies the binary code is somehow
> infringing.  I would suggest changing the word to "non-GPL" or "Vendor
> Supported" since this is more accurate.   Just a suggestion.
> 
> Thanks Jeff

I believe the use of the word is quite correct. Taint is synonymous to
contaminate. When you add a closed-source driver, the kernel is no
longer pure GPL, it's been contaminated by a non-GPL part. 

There may be other connotations to the word in various regions in the
english speaking world that give it much darker meanings, though, that I
don't know about. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
