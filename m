Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWGVA5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWGVA5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWGVA5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:57:15 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:57270 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750702AbWGVA5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:57:15 -0400
Date: Fri, 21 Jul 2006 15:45:08 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Matt LaPlante <kernel1@cyberdogtech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How long to wait on patches?
In-Reply-To: <20060721205056.18b428eb.kernel1@cyberdogtech.com>
Message-ID: <Pine.LNX.4.63.0607211541560.5705@qynat.qvtvafvgr.pbz>
References: <20060721205056.18b428eb.kernel1@cyberdogtech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006, Matt LaPlante wrote:

> I checked the FAQ but didn't see an answer to this.  Over the past few weeks 
> I've submitted probably around 8 simple typo-fix patches all of which seemed 
> to be approved by others on the list.  I've been following the GIT, but these 
> patches haven't been merged yet.  I know people are busy with other things, 
> probably more important, but I would like to know how long is "acceptable" to 
> wait before I should re-submit a patch.  Obviously if enough time passes, 
> patches start to break as source files change.  I don't mean to be a nuisance; 
> I'm just trying to determine proper protocol.  That and the fact I can submit 
> several more patches once I get some of these old ones out of my queue. :)

be sure to watch the -mm tree as well, a lot of patches are picked up by Andrew 
to be fed to Linus that way

this is a particularly bad week since almost all the core developers were up at 
OLS.

one thing you may want to look at doing (hosting permitting) is to setup a git 
tree to just hold your trivial patches so that they can be pulled easily.

I thought there was a person who was maintaining a -trivial tree for this 
purpose, I don't remember who it was though.

David Lang
