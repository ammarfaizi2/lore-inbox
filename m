Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUBMJwS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 04:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266886AbUBMJwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 04:52:18 -0500
Received: from ns.schottelius.org ([213.146.113.242]:51948 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S266884AbUBMJwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 04:52:17 -0500
Date: Fri, 13 Feb 2004 10:52:23 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: Re: harddisk or kernel problem?
Message-ID: <20040213095223.GE1881@schottelius.org>
References: <20040213075403.GC1881@schottelius.org> <20040213081104.GD1881@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213081104.GD1881@schottelius.org>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius [Fri, Feb 13, 2004 at 09:11:04AM +0100]:
> forgot the config and the dmesg..
> 

Now additionally I found a mistake in my thoughts:

hda/part3 makes the errors, hda/part4 is the cryptoloop partition.
So in fact the error occurs when mounting this particular partition, but
seems to be an error on partition3. Can someone give me a hint on what
todo?

Sincerly,

Nico

ps: if somebody answers/answers me, please cc-me. Thanks.
