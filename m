Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTFXWvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTFXWvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:51:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:31388 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262423AbTFXWvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:51:39 -0400
Subject: Re: [Must-fix] Keyboard occasionally endlessly repeating keys
From: john stultz <johnstul@us.ibm.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030620202444.GD22732@wohnheim.fh-wedel.de>
References: <20030620202444.GD22732@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1056495483.1027.260.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Jun 2003 15:58:04 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-20 at 13:24, Jörn Engel wrote:
> After having upgraded my notebook to 2.5.72, I noticed a rare problem,
> that occurs about twice a day, maybe more.  After pressing a key, it
> gets repeated endlessly until the next key is pressed.  When typing
> fast, it is quite possible to cover up a couple of these, as the
> repeats appear to happen at the set keyboard rates.  Problem never
> occured with any 2.4 kernel.


Assuming you're still seeing this, does booting w/ "clock=pit" resolve
the problem? If so could you send me more info about the system? (is
speed step enabled, etc?)

thanks
-john


