Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWAJS4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWAJS4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWAJS4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:56:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56686 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751179AbWAJS4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:56:34 -0500
Date: Tue, 10 Jan 2006 19:58:13 +0100
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110185811.GV3389@suse.de>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3F986.4090209@mbligh.org> <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org> <43C3E74D.7060309@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3E74D.7060309@wolfmountaingroup.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Jeff V. Merkey wrote:
> RH ES uses 4:4 which is ideal and superior to this hack.

This isn't a hack, it's just making the offset configurable so you can
get the best of what you want.

And 4:4 may be ideal in a peyote haze, so whatever.

-- 
Jens Axboe

