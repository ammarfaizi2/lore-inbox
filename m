Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263834AbUFFRP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUFFRP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUFFRP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:15:27 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:5248 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263834AbUFFRP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:15:26 -0400
Date: Sun, 6 Jun 2004 19:16:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] Mousedev - better button handling under load
Message-ID: <20040606171601.GA5845@ucw.cz>
References: <200406050249.02523.dtor_core@ameritech.net> <200406060940.21209.dtor_core@ameritech.net> <20040606160245.GA1350@ucw.cz> <200406061149.45284.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406061149.45284.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 11:49:45AM -0500, Dmitry Torokhov wrote:
> On Sunday 06 June 2004 11:02 am, Vojtech Pavlik wrote:
> > On Sun, Jun 06, 2004 at 09:40:20AM -0500, Dmitry Torokhov wrote:
> > > On Sunday 06 June 2004 04:58 am, Vojtech Pavlik wrote:
> > > > Thanks for this. Can I just pull from your tree, or is there more that I
> > > > shouldn't take?
> > > > 
> > > 
> > > I am exporting stuff to my bk tree on as-needed basis so there is nothing
> > > extra (and no mousedev changes yet). Do you want button handling changes
> > > only or you do also want tapping emulation exported?
> > 
> > Tapping is fine as well.
> > 
> 
> OK, when you are ready please do:
> 
> 	bk pull bk://dtor.bkbits.net/input

Done. Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
