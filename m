Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWAPUNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWAPUNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWAPUNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:13:20 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:44679 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP
	id S1751180AbWAPUNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:13:19 -0500
Date: Mon, 16 Jan 2006 22:10:51 +0200 (EET)
From: Samuel Ortiz <samuel.ortiz@nokia.com>
X-X-Sender: samuel@irie
Reply-To: samuel.ortiz@nokia.com
To: ext Stuffed Crust <pizza@shaftnet.org>
cc: Sam Leffler <sam@errno.com>, Jeff Garzik <jgarzik@pobox.com>,
       Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
In-Reply-To: <20060116195008.GB12748@shaftnet.org>
Message-ID: <Pine.LNX.4.58.0601162204240.17348@irie>
References: <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com>
 <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost>
 <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com>
 <20060115152034.GA1722@shaftnet.org> <43CAA853.8020409@errno.com>
 <20060116172817.GB8596@shaftnet.org> <Pine.LNX.4.58.0601162056261.17348@irie>
 <20060116195008.GB12748@shaftnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Jan 2006 20:10:47.0500 (UTC) FILETIME=[F06448C0:01C61AD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, ext Stuffed Crust wrote:

> You may hear another beacon when the STA is awake, you may not.  BSSID
> filtering has nothing to do with 802.11 power save, but rather is
> intented to reduce the host load (interrupts, processing overhead) and
> thus the host power consumption.
I know that and I know a bit about 802.11 PS as well.
I was talking about host powersaving, not 802.11. Sorry for the confusion.

What I meant is that having an 802.11 stack capable of living with less
than a beacon every couple of beacon intervals would be nice as well.

Cheers,
Samuel.

