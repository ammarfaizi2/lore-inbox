Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266326AbUANOkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUANOkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:40:21 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:15847 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266326AbUANOkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:40:13 -0500
Date: Wed, 14 Jan 2004 15:40:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Message-ID: <20040114144010.GA28802@ucw.cz>
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <20040111235025.GA832@ucw.cz> <Pine.LNX.4.58.0401120004110.601@pervalidus.dyndns.org> <20040112083647.GB2372@ucw.cz> <20040112135655.A980@pclin040.win.tue.nl> <20040114142445.GA28377@ucw.cz> <200401141444.i0EEibZ1000724@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401141444.i0EEibZ1000724@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 02:44:37PM +0000, John Bradford wrote:

> > COMMENTS?
> 
> What about keyboards which support USB and PS/2 connections - will
> users be able to avoid changing keymaps depending on how they connect
> their keyboard or are there keyboards out there which sufficiently
> dissimilar codes using both connection methods that we can't easily do
> this?

USB and PS/2 already work the same on both 2.4 and 2.6. There may be
problems with media and internet keys, as they're often non-standard,
but that can be fixed by using the 'setkeycodes' utility.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
