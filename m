Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWG0Pjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWG0Pjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWG0Pjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:39:51 -0400
Received: from alpha.polcom.net ([83.143.162.52]:16620 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S932570AbWG0Pju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:39:50 -0400
Date: Thu, 27 Jul 2006 17:39:40 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Hans Reiser <reiser@namesys.com>, Matthias Andree <matthias.andree@gmx.de>,
       lkml@lpbproductions.com, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
In-Reply-To: <20060726131709.GB5270@ucw.cz>
Message-ID: <Pine.LNX.4.63.0607271732010.8976@alpha.polcom.net>
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org>
 <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com>
 <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org>
 <44C4813E.2030907@namesys.com> <20060726131709.GB5270@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Pavel Machek wrote:

> Hi!
>
>>> of the story for me. There's nothing wrong about focusing on newer code,
>>> but the old code needs to be cared for, too, to fix remaining issues
>>> such as the "can only have N files with the same hash value".
>>>
>> Requires a disk format change, in a filesystem without plugins, to fix it.
>
> Well, too bad, if reiser3 is so broken it needs on-disk-format-change,
> then I guess doing that change is the right thing to do...

Sorry for my stupid question, but could you tell me why starting to make 
incompatible changes to reiserfs3 now (when reiserfs3 "technology" is 
rather old) and making reiserfs3 unstable (again), possibly for several 
months or even years is better than fixing big issues with reiser4 (if 
there are any really big left) merging it and trying to stabilize it?

For end user both ways will result in mkfs so...


Thanks,

Grzegorz Kulewski

