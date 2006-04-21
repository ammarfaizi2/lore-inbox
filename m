Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWDUGsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWDUGsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWDUGsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:48:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49498 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751152AbWDUGsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:48:30 -0400
Date: Fri, 21 Apr 2006 08:49:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Piet Delaney <piet@bluelane.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice status - git clone failed.
Message-ID: <20060421064905.GS4717@suse.de>
References: <20060420142902.GC4717@suse.de> <1145572268.25127.69.camel@piet2.bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145572268.25127.69.camel@piet2.bluelane.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2006, Piet Delaney wrote:
> On Thu, 2006-04-20 at 16:29 +0200, Jens Axboe wrote:
> > git://brick.kernel.dk/data/git/splice.git
> 
> I just installed the latest git (20-Apr-2006) and tried
> to clone your example and got an EOF. Any suggestions?
> -------------------------------------------------------
> /nethome/piet/src/splice$ git clone
> git://brick.kernel.dk/data/git/splice.git
> fatal: unexpected EOF
> fetch-pack from 'git://brick.kernel.dk/data/git/splice.git' failed.
> ------------------------------------------------------

Oh, new directory and I forgot to kick the git-daemon. It should work
now.

-- 
Jens Axboe

