Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbSKTFYP>; Wed, 20 Nov 2002 00:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbSKTFYP>; Wed, 20 Nov 2002 00:24:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5138 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267628AbSKTFYP>;
	Wed, 20 Nov 2002 00:24:15 -0500
Date: Tue, 19 Nov 2002 21:24:43 -0800
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH(2.5.48): Eliminate pcidev.driver_data
Message-ID: <20021120052442.GF21953@kroah.com>
References: <20021119211626.A2389@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119211626.A2389@baldur.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 09:16:26PM -0800, Adam J. Richter wrote:
> At 2.5.45, I reposted this
> patch and Greg Kroah-Hartman said that he would submit it to you in
> "the next round of pci cleanups I'm going to be sending to Linus", but
> it seems to have fallen through the cracks since then.

I've been on "vacation" this week, and wanted to get my pcibios cleanup
changes done first (which I just sent off.)  Sorry for the delay.

This patch looks good, and if Linus doesn't take it directly, I'll put
it up in a tree to send to him later :)

Sorry again for the delay,

greg k-h
