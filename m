Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750822AbWFEJ03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWFEJ03 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWFEJ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:26:28 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:17819 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750815AbWFEJ02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:26:28 -0400
Date: Mon, 5 Jun 2006 02:26:25 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Marty Leisner <leisner@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mixing cache size on xeon4's in smp system
Message-ID: <20060605092625.GB26189@tuatara.stupidest.org>
References: <200606042317.k54NHfIS026034@dell2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606042317.k54NHfIS026034@dell2.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 11:17:41PM +0000, Marty Leisner wrote:

> I've heard advice "see if flakey things happen" -- that's not advice
> I want to follow...

it might work, i don't think anyone would really recommend it

if it's a non-critical machine try it out, beat it up with kernel
compiles or something to stress test it a bit
