Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932876AbWAFRXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbWAFRXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbWAFRW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:22:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:36364 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932849AbWAFRWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:22:55 -0500
Date: Fri, 6 Jan 2006 18:22:47 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Nauman Tahir <nauman.tahir@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] why all the patches get messed up here!!!
Message-ID: <20060106172247.GF7142@w.ods.org>
References: <f0309ff0601052340p492e4646ib8a4cde25fd29872@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0309ff0601052340p492e4646ib8a4cde25fd29872@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:40:43PM -0800, Nauman Tahir wrote:
> hi all,
> May I ask why all kernel patches just get in here in the list?
> I mean to say that isn't it better to have another list only for this
> purpose and let this mailing list be a discussion forum. I login here
> to see different issues. its a wonderful resource.
> I understand that alot of code is discussed here but in case of PATCH
> I think it would be better to have a separate archive.
> No offence just wanted to ask

Hmmm it would be terrible. Just thinking about what a conversation
would look like :

  "Hi guys, I found a bug in xxx subsystem, basically it did blablabla
   to my box when I tried to blablabla. I fixed it the dirty way, please
   consult the patch list and look for subject XXX.
   => reply :
   Hi foo,
   there was an cleaner fix, yours is buggy because blablabla. please
   use my reply to your mail on the patch list instead.
  "

Most people here *comment* patches :
  - methods
  - bugs
  - typos
  - coding style

There's no way to do this on two separate lists. It's already very
annoying when someone posts an HTTP link to some content outside !

> Regards
> Nauman

Willy

