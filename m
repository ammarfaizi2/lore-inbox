Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbUKHAd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUKHAd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 19:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUKHAd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 19:33:27 -0500
Received: from mail2.epfl.ch ([128.178.50.133]:27919 "HELO mail2.epfl.ch")
	by vger.kernel.org with SMTP id S261176AbUKHAdY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 19:33:24 -0500
Date: Mon, 8 Nov 2004 01:33:23 +0100
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
Message-ID: <20041108003323.GE5360@magma.epfl.ch>
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <418EB8EB.30405@kolivas.org>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 11:08:11AM +1100, Con Kolivas wrote:

> >>>I use DVB with VDR, but I can do the crash all the time without VDR, all
> >>>I have to do is to have xawtv running and having a process that write
> >>>fast enough data to an HD (I tested xfs, reiserfs, ext2 and ext3 with
> >>>same result). If I don't have xawtv running I can't make crashing my
> >>>system which is rock stable :-)
> >>
> >>Is xawtv running as root or with real time privileges? That could do it.

> What does 'top' show as the PRI for xawtv?

I just started it and see 16 as priority in top. Should I renice it or
start it another way ?
-- 
	Grégoire Favre
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
