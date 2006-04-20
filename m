Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWDTWbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWDTWbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWDTWbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:31:14 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:32207 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S932090AbWDTWbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:31:12 -0400
Subject: Re: splice status - git clone failed.
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Jens Axboe <axboe@suse.de>
Cc: Piet Delaney <piet@bluelane.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060420142902.GC4717@suse.de>
References: <20060420142902.GC4717@suse.de>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Thu, 20 Apr 2006 15:31:08 -0700
Message-Id: <1145572268.25127.69.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2006 22:31:12.0194 (UTC) FILETIME=[20BB1220:01C664CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 16:29 +0200, Jens Axboe wrote:
> git://brick.kernel.dk/data/git/splice.git

I just installed the latest git (20-Apr-2006) and tried
to clone your example and got an EOF. Any suggestions?
-------------------------------------------------------
/nethome/piet/src/splice$ git clone
git://brick.kernel.dk/data/git/splice.git
fatal: unexpected EOF
fetch-pack from 'git://brick.kernel.dk/data/git/splice.git' failed.
------------------------------------------------------

The shapshot is fine.

-- 
---
piet@bluelane.com

