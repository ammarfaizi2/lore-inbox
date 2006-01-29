Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWA2Eo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWA2Eo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 23:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWA2Eo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 23:44:56 -0500
Received: from c-67-163-99-44.hsd1.tx.comcast.net ([67.163.99.44]:57496 "EHLO
	leaper.linuxtx.org") by vger.kernel.org with ESMTP id S1750799AbWA2Eoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 23:44:55 -0500
Date: Sat, 28 Jan 2006 22:43:07 -0600
From: "Justin M. Forbes" <jmforbes@linuxtx.org>
To: Chuck Wolber <chuckw@quantumlinux.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
Message-ID: <20060129044307.GA23553@linuxtx.org>
References: <20060128021749.GA10362@kroah.com> <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 08:30:25PM -0800, Chuck Wolber wrote:
> 
> Please correct me if I'm wrong here, but aren't we supposed to stop doing 
> this for the 2.6.14 release now that 2.6.15 is out?
> 
I don't see a problems with doing additional stable releases for any
kernel, I just wouldn't commit to supporting any specific number of
releases.  Basically if people send enough patches to warrant a
review/release there is obviously some interest.  What is the harm?

Justin
