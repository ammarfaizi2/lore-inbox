Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWANK53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWANK53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 05:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWANK52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 05:57:28 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:42524 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751232AbWANK52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 05:57:28 -0500
Date: Sat, 14 Jan 2006 11:57:21 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060114105721.GA18170@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <20060113074749.GA7103@midnight.suse.cz> <20060113220252.GA1516@hansmi.ch> <200601132358.33861.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601132358.33861.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry

On Fri, Jan 13, 2006 at 11:58:33PM -0500, Dmitry Torokhov wrote:
> One little thing - I think that we should report FN key even if PowerBook
> support is disabled. Can I solicit input on the patch below (I also rearranged
> teh code slightly)? 

Yeah, all looks fine for me.

Greets,
Michael
