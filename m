Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVASQvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVASQvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVASQvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:51:33 -0500
Received: from styx.suse.cz ([82.119.242.94]:20186 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261772AbVASQvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:51:31 -0500
Date: Wed, 19 Jan 2005 17:53:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hannes Reinecke <hare@suse.de>
Cc: dtor_core@ameritech.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Remove input_call_hotplug
Message-ID: <20050119165335.GA9081@ucw.cz>
References: <41ED2457.1030109@suse.de> <d120d50005011807566ee35b2b@mail.gmail.com> <41EE2F82.3080401@suse.de> <d120d500050119060530b57cd7@mail.gmail.com> <41EE6BA8.6020705@suse.de> <d120d500050119064461d21d80@mail.gmail.com> <41EE7521.1010900@suse.de> <20050119154946.GA8839@ucw.cz> <41EE81CF.2010703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EE81CF.2010703@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 04:50:39PM +0100, Hannes Reinecke wrote:
> Vojtech Pavlik wrote:
> >On Wed, Jan 19, 2005 at 03:56:33PM +0100, Hannes Reinecke wrote:
> >
> >
> >>oops. hadn't thought of that. But of course, you are correct.
> >>So better be using monotonically increasing numbers.
> >>
> >>New patch attached.
> >
> >
> >This one looks quite OK to me.
> >
> Will you put it into your bk-input tree so that it will eventually find 
> its way towards akpm/linus ?
 
Unless anyone objects in a while, yes.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
