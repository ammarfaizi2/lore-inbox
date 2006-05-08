Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWEHH0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWEHH0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWEHH0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:26:10 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:58786 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932184AbWEHH0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:26:08 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Remove silly messages from input layer.
Date: Mon, 8 May 2006 17:25:29 +1000
User-Agent: KMail/1.9.1
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, dtor_core@ameritech.net,
       "Martin J. Bligh" <mbligh@mbligh.org>
References: <20060504024404.GA17818@redhat.com> <20060505152748.GA22870@redhat.com> <445EE899.6040908@aitel.hist.no>
In-Reply-To: <445EE899.6040908@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605081725.29977.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 May 2006 16:43, Helge Hafting wrote:
> Dave Jones wrote:
> >On Fri, May 05, 2006 at 12:31:23PM +0200, Pavel Machek wrote:
> > > If you only pressed single key -- your keyboard is crap or there's
> > > some problem in the driver.
> > >
> > > If you never pressed any key -- your keyboard is crap or there's
> > > some problem in the driver.
> >
> >That's hardly a constructive answer when the keyboard is a part of
> >a laptop.  Crap hardware exists, get used to it.
>
> If some laptop comes with a bad keyboard, please blacklist
> it so future linux users can avoid the brand when shopping
> for hardware.

This is great in theory but if we end up blacklisting half of the hardware out 
there we're stuffed. The truth is most hardware out there is cheap and nasty 
and sells in vast quantities. We have workarounds for timer code being buggy 
on virtually half the motherboards out there on amd64 for example...

-- 
-ck
