Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWHAJUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWHAJUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWHAJUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:20:15 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:49899 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S932537AbWHAJUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:20:13 -0400
Message-ID: <1153.153.96.175.159.1154423993.squirrel@secure.sipsolutions.net>
In-Reply-To: <1f1b08da0607312337l34eabc56jdee7b056acd9a71a@mail.gmail.com>
References: <1152821370.6845.9.camel@localhost>
    <1152831309.23037.31.camel@localhost.localdomain>
    <1f1b08da0607312337l34eabc56jdee7b056acd9a71a@mail.gmail.com>
Date: Tue, 1 Aug 2006 11:19:53 +0200 (CEST)
Subject: Re: [BUG] no sound on ppc mac mini
From: "Johannes Berg" <johannes@sipsolutions.net>
To: "john stultz" <johnstul@us.ibm.com>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "lkml" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
>> Is this really a current git or an -rc1 snapshot ? The crashes on boot
>> should have been fixed ... unless there is another problem on the mac
>> mini. Can you try having them as modules instead ?
>
> I know you mentioned there was a fix for this somewhere, but as
> motivation to get it flowing to mainline, here's what I get w/ the
> current -rc3-git and the sound bits compiled as modules:

The fixes are sitting in the alsa mercurial repository waiting to go
upstream...

Not My Fault (TM) ;)

johannes
