Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVCLFWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVCLFWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 00:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVCLFW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 00:22:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:27366 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261907AbVCLFVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 00:21:53 -0500
Subject: Re: Average power consumption in S3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Martin Josefsson <gandalf@wlug.westbo.se>,
       Volker Braun <volker.braun@physik.hu-berlin.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050312045828.GA19215@thunk.org>
References: <20050309142612.GA6049@informatik.uni-bremen.de>
	 <1110388970.1076.48.camel@tux.rsn.bth.se>
	 <20050310180826.GA6795@informatik.uni-bremen.de>
	 <20050311034615.GA314@thunk.org> <1110516679.32557.350.camel@gaston>
	 <20050311174433.GA6735@thunk.org> <1110584902.5809.116.camel@gaston>
	 <20050312045828.GA19215@thunk.org>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 16:21:13 +1100
Message-Id: <1110604873.19810.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 23:58 -0500, Theodore Ts'o wrote:

> If this is true, then ATI probably won't be able to tell us anything
> useful, so we're only going to find out if people in the Thinkpad
> division are willing to tell us something useful (and their track
> record for being helpful has not been particularly stellar).
> 
> And what I was thinking about doing was having the CONFIG option only
> do it for machines that were detected as being IBM Thinkpads, not all
> Radeon chips.  The blacklist would be for specific IBM thinkpad
> models; what I'm guessing here is that it's likely that all or most
> modern IBM thinkpads are going to be wired the same way on the
> motherboard.  

Fine with me then.

