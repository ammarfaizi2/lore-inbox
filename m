Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWEEPh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWEEPh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWEEPh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:37:28 -0400
Received: from albireo.ucw.cz ([84.242.87.5]:43907 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751566AbWEEPh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:37:27 -0400
Date: Fri, 5 May 2006 17:37:28 +0200
From: Martin Mares <mj@ucw.cz>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       dtor_core@ameritech.net, "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <mj+md-20060505.153608.7268.albireo@ucw.cz>
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz> <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com> <20060504183840.GE18962@redhat.com> <20060505103123.GB4206@elf.ucw.cz> <20060505152748.GA22870@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505152748.GA22870@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, May 05, 2006 at 12:31:23PM +0200, Pavel Machek wrote:
> 
>  > If you only pressed single key -- your keyboard is crap or there's
>  > some problem in the driver.
>  > 
>  > If you never pressed any key -- your keyboard is crap or there's
>  > some problem in the driver.
> 
> That's hardly a constructive answer when the keyboard is a part of
> a laptop.  Crap hardware exists, get used to it.

Yes, but removing a message which can be sometimes useful is hardly
justified by crappy hardware sometimes triggering it. If it's triggered
too often, it should be rate-limited, not removed.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"It's a lemon tree, my dear Watson." -- Sherlock Holmes (?)
