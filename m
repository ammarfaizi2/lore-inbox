Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271165AbRHOMJX>; Wed, 15 Aug 2001 08:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271166AbRHOMJN>; Wed, 15 Aug 2001 08:09:13 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:10252 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S271165AbRHOMJF>; Wed, 15 Aug 2001 08:09:05 -0400
Message-ID: <3B7A666C.567260F3@delusion.de>
Date: Wed, 15 Aug 2001 14:09:16 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: rui.p.m.sousa@clix.pt
CC: Gerd Knorr <kraxel@bytesex.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BT878 audio dma
In-Reply-To: <Pine.LNX.4.33.0108151358390.9296-100000@sophia-sousar2.nice.mindspeed.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rui.p.m.sousa@clix.pt wrote:
> 
> On Wed, 15 Aug 2001, Udo A. Steinberg wrote:
> 
> The bt878 must be grabing an audio device. If so, and when the bt878
> module is loaded first, thememu10k1 should be using /dev/dsp1 (and
> /dev/dsp2).
> 
> When you compile the bt878 as a module and _loaded it after_ the
> emu10k1 module does it still work (proving my point above)?

Yes, then it still works. Is there an easy way to tell which driver
uses which dsp device?

Regards,
Udo.
