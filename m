Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUIVHae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUIVHae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 03:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUIVHae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 03:30:34 -0400
Received: from styx.suse.cz ([82.119.242.94]:37514 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S261239AbUIVHa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 03:30:26 -0400
Date: Wed, 22 Sep 2004 09:30:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New input patches
Message-ID: <20040922073048.GB5116@ucw.cz>
References: <200409162358.27678.dtor_core@ameritech.net> <20040921121040.GA1603@ucw.cz> <200409210815.34509.dtor_core@ameritech.net> <200409220212.23110.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409220212.23110.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 02:12:23AM -0500, Dmitry Torokhov wrote:
> On Tuesday 21 September 2004 08:15 am, Dmitry Torokhov wrote:
> > On Tuesday 21 September 2004 07:10 am, Vojtech Pavlik wrote:
> 
> > > So the condition needs to be inverted. However, it's not necessary at
> > > all, since the input layer will not pass the RAW events when the MSC_RAW
> > > bit is not set.
> > 
> > I see, my bad. I will drop that bit.
> > 
> > Thanks for the comments!
> > 
> 
> Vojtech,
> 
> I have fixed the aforementioned bug and re-diffed the patches against your
> latest tree. Please do:
> 
> 	bk pull bk://dtor.bkbits.net/input
> 
> Thanks!
 
Done.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
