Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTIDT62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbTIDT62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:58:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:52913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264830AbTIDT61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:58:27 -0400
Date: Thu, 4 Sep 2003 12:55:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
In-Reply-To: <20030904182606.GB27650@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0309041247380.940-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've said I want the patch reverted. I still want that, because you
> changed way too quickly with too little testing. That does not mean
> I'm not going to accept your patches in future. (In fact, my plan is
> to  get -test3 version of swsusp back for -test5, then fix up driver
> model/swsusp until we have -test3 functionality back, then start
> taking your patches). 

That's fine. Do what you want at your own pace, with your own code. 

I don't think you understood my assertion of not working with you, though.  
I'm not going to wait around for you to merge my patches, or take more
abuse from you. I have better things to do, and a stringent time frame in
which to do them.

I recommend either a) accepting my changes and fixes, and help merge
Nigel's 2.4 changes into the base or b) accepting the fork, merging
Nigel's changes, and later trying to merge the two source bases. 


	Pat

