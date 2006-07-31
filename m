Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWGaUcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWGaUcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWGaUcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:32:12 -0400
Received: from blinkenlights.ch ([62.202.0.18]:4908 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S1030199AbWGaUcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:32:11 -0400
Date: Mon, 31 Jul 2006 22:32:09 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
Message-Id: <20060731223209.173908cf.reiser4@blinkenlights.ch>
In-Reply-To: <20060731200718.GA13257@merlin.emma.line.org>
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>
	<20060731165406.GA8526@merlin.emma.line.org>
	<20060731195621.367ed702.reiser4@blinkenlights.ch>
	<20060731200718.GA13257@merlin.emma.line.org>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> All the more important to think about FS requirements *before*
> newfs-ing if a quick "one day for rsync/star/dump+restore" isn't
> available. If you're hitting, for instance, the hash collision problem
> in reiser3, you're as dead as with a FS without inodes.

Quoting myself:
>> Let's face it: Shit happens and nobody is perfect. A filesystem should
>> be flexible (modern..) and support Admin/User-needs.

Of COURSE you should think BEFORE creating the filesystem.
But if you somehow failed to do it 'the right thing' your filesystem
shouldn't let you down.
