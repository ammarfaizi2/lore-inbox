Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbSL3Kfk>; Mon, 30 Dec 2002 05:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbSL3Kfk>; Mon, 30 Dec 2002 05:35:40 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:224
	"EHLO localhost") by vger.kernel.org with ESMTP id <S266849AbSL3Kfj>;
	Mon, 30 Dec 2002 05:35:39 -0500
Date: Mon, 30 Dec 2002 02:43:57 -0800
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, abacus_an@yahoo.co.in
Subject: Re: kernel compilation: pls send cc to me
Message-ID: <20021230104357.GB13892@localhost>
References: <20021230103025.GA13892@localhost> <200212301038.gBUAcZWw000609@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212301038.gBUAcZWw000609@darkstar.example.net>
User-Agent: Mutt/1.4i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh...
Well, I stand corrected. I never noticed any difference compiling with 
gcc-2.95 versus compiling with 3.2.

What is the recommended version then?

Regards
Josh

On Mon, Dec 30, 2002 at 10:38:35AM +0000, John Bradford wrote:
> > The kernel is meant to be very portable anyway.
> 
> Not really.  The kernel is designed to compiled with a specific
> compiler.  A GCC version other than the recommended version might
> uncover bugs that should be fixed anyway, but it might also break
> things that are worked around for the recommended GCC version.
> 
> John.
