Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVHUVRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVHUVRx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVHUVRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:17:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:22986 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751113AbVHUVRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:17:53 -0400
To: Imanpreet Arora <imanpreet@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux under 8MB
References: <c26b9592050818151154ff1a89@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 21 Aug 2005 13:21:43 -0600
In-Reply-To: <c26b9592050818151154ff1a89@mail.gmail.com> (Imanpreet Arora's
 message of "Fri, 19 Aug 2005 03:41:30 +0530")
Message-ID: <m1k6ifumd4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imanpreet Arora <imanpreet@gmail.com> writes:

> Hi all,
>
>               For the last couple of days, I have been trying to set
> up linux kernel under 8MB. So far I have set up a linux 2.4.31, which
> just works under 8MB. However, I would be grateful if someone could
> help with the following queries
>
> a)          Is linux2.4 just the right option? What about linux 2.0.x?
> Or for that matter even <2.0

2.4 is the worst choice.  You want either 2.6 + patches from
the linux-tiny project or you want a noticably older kernel.
The 2.6 option as it is works with what is being developed should
be the more maintainable option.

Eric
