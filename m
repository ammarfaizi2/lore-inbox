Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUI1CfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUI1CfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 22:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUI1CfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 22:35:07 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:27991 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267508AbUI1CfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 22:35:01 -0400
Message-ID: <8e6f9472040927193565a21c7d@mail.gmail.com>
Date: Mon, 27 Sep 2004 22:35:00 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch] i386: Xbox support
Cc: Ed Schouten <ed@il.fontys.nl>, linux-kernel@vger.kernel.org,
       alan@redhat.com
In-Reply-To: <4158AA5B.8090601@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <65184.217.121.83.210.1096308147.squirrel@217.121.83.210>
	 <4158AA5B.8090601@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 10:03:39 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Ed Schouten wrote:
> > Added support for Microsoft Xbox gaming consoles by adding the config
> > option 'CONFIG_X86_XBOX'. This patch is very minimalistic and should give
> > the fellows at xbox-linux.org a starting point.
> 
> Any real point to merging this? (I honestly don't know, I don't follow the
> xbox hacking scene).

As someone who owns a modchipped xbox (used mainly for media center
stuff), I would appreciate having fewer out of tree patches to apply
in order to run a new kernel. I can't vouch for any kind of critical
mass of users, however.

-- 
Will Dyson
