Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262598AbSJGTI4>; Mon, 7 Oct 2002 15:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262603AbSJGTI4>; Mon, 7 Oct 2002 15:08:56 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:28289 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262598AbSJGTIz>;
	Mon, 7 Oct 2002 15:08:55 -0400
Date: Mon, 7 Oct 2002 21:14:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Steve Dover <swdlinunx@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: PC speaker dead in 2.5.40?
Message-ID: <20021007211427.A833@ucw.cz>
References: <3DA1BD31.4040707@earthlink.net> <20021007070857.GA1927@rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021007070857.GA1927@rivenstone.net>; from jhf@rivenstone.net on Mon, Oct 07, 2002 at 03:08:57AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 03:08:57AM -0400, Joseph Fannin wrote:

> > Configuring a kernel with Sound support with either
> > OSS or ALSA, I still get nothing from my PC speaker.
> > Works fine under 2.4.18.
> 
>     Look under all the submenus in the Input section of
>     "menuconfig" for the speaker entry and enable it.
> 
>     There's a good technical reason why the speaker is an input
>     device, but hiding it in the menus is *bad*.

Send me a patch that fixes this - if you know how.

-- 
Vojtech Pavlik
SuSE Labs
