Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUBYUrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUBYUrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:47:45 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:19329 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261436AbUBYUoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:44:19 -0500
Message-ID: <403D0A3B.9000507@tmr.com>
Date: Wed, 25 Feb 2004 15:48:59 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neptune <neptune@nowhere.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adding a new filesystem
References: <bv8a7b$ir1$1@reader08.wxs.nl>
In-Reply-To: <bv8a7b$ir1$1@reader08.wxs.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neptune wrote:
> Hello to all,
> 
> I'd like to write a module to allow the mount program to mount a 
> filesystem that is not in the kernel source tree by now.
> 
> Could someone point me to some documentation, quickstart guide or 
> something?

Start looking for the user filesystem stuff. I have no idea if this will 
  actually but useful, but have have an old note that I thought you 
could pretty much roll your own f/s in this framework.
