Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSE2QeG>; Wed, 29 May 2002 12:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSE2QeF>; Wed, 29 May 2002 12:34:05 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:1934 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313558AbSE2QeE>;
	Wed, 29 May 2002 12:34:04 -0400
Date: Wed, 29 May 2002 18:33:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Gerald Champagne <gerald@io.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
Message-ID: <20020529183343.A19610@ucw.cz>
In-Reply-To: <1022680784.2945.24.camel@wiley> <3CF4D19F.9080402@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 03:03:27PM +0200, Martin Dalecki wrote:

> BTW> The next thing to be gone is simple the fact that we drag
> around the id information permanently, where infact only
> some capabilitie fields are sucked out of it and the
> device identification string is only needed for reporting
> during boot-up.

Also for black/whitelists. And we're going to need those, though maybe
the current data in them is not worth much.

-- 
Vojtech Pavlik
SuSE Labs
