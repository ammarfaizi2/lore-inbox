Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUAJLEs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 06:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbUAJLEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 06:04:48 -0500
Received: from levante.wiggy.net ([195.85.225.139]:64993 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S265062AbUAJLEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 06:04:47 -0500
Date: Sat, 10 Jan 2004 12:04:43 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [1/4] better i386 CPU selection
Message-ID: <20040110110443.GA29693@wiggy.net>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Nick Piggin <piggin@cyberone.com.au>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de> <20040110005232.GD25089@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110005232.GD25089@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Adrian Bunk wrote:
> - changed the i386 CPU selection from a choice to single options for
>   every cpu

There was another patch last week which added a seperate option for
Centrino CPUs, perhaps you can fold that into this patch? The current
situation is quite confusing since none of the CPU choices mention
Centrine.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

