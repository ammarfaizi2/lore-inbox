Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRJZJjL>; Fri, 26 Oct 2001 05:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278081AbRJZJjC>; Fri, 26 Oct 2001 05:39:02 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:22287 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S278080AbRJZJiv>; Fri, 26 Oct 2001 05:38:51 -0400
Date: Fri, 26 Oct 2001 11:39:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jim Hull <imaginos@imaginos.net>, linux-kernel@vger.kernel.org
Subject: Re: dvd and filesystem errors under 2.4.13
Message-ID: <20011026113925.A2315@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0110250907210.425-100000@rosebud> <E15wnTN-0005MC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15wnTN-0005MC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 25, 2001 at 05:35:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 05:35:12PM +0100, Alan Cox wrote:
> > Are you saying this is possibly a hardware issue ?
> 
> Could be a cabling or RAM issue,could also be a driver bug of some

Hmm, I've now received three reports of data corruption in 2.4.13, on
various VIA chipsets, only when using DMA. I wonder what went amiss
again ...

-- 
Vojtech Pavlik
SuSE Labs
