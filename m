Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161354AbWKPEG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161354AbWKPEG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 23:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162270AbWKPEG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 23:06:56 -0500
Received: from mmail.enter.net ([216.193.128.40]:29417 "EHLO mmail.enter.net")
	by vger.kernel.org with ESMTP id S1161354AbWKPEGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 23:06:54 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 23:06:43 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611150059.kAF0xBTl009796@hera.kernel.org> <200611142253.29866.dhazelton@enter.net> <20061115114055.05d9df8f@localhost.localdomain>
In-Reply-To: <20061115114055.05d9df8f@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611152306.43786.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 06:40, Alan wrote:
> > Point is that it is still only one platform. Or don't you understand the
> > point I was making?
>
> Given the Intel chipset platform appears to be over half the market it
> makes sense to do things right there. It also encourages other vendors to
> fix their stuff or send us patches to do so.
>
> So I don't think anyone gives a damn about your personal issues with
> Intel.
>
> Alan

I have no personal issues with Intel. I just always avoided their stuff 
because it always cost more and wasn't as well supported in Linux back when I 
first started using Linux.

Anyway, my point still stands. One platform does not a whitelist make. Instead 
why not make the MSI support optional and a build-option? I do believe that I 
even suggested such. This would allow for the people that want it (or need 
it) to have it and would keep a potentially dangerous option from being used.

Now, since I'm at the end of options in explaining my point I'm going to start 
ignoring further messages on this topic.

DRH
