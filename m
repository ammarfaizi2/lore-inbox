Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278323AbRJMQOH>; Sat, 13 Oct 2001 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278324AbRJMQN5>; Sat, 13 Oct 2001 12:13:57 -0400
Received: from hermes.toad.net ([162.33.130.251]:22483 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S278323AbRJMQNu>;
	Sat, 13 Oct 2001 12:13:50 -0400
Subject: Re: APM trouble
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 13 Oct 2001 12:13:40 -0400
Message-Id: <1002989621.764.35.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kamil Kompa wrote:
> I have a trouble with apmd.

IIUC your machine works with a stock kernel but not
with a kernel you compile yourself.  There are many
possible causes of this.  What I would do is try to
compile a kernel identical to the stock binary kernel
that works.  Then reconfigure one thing at a time,
rebuilding and rebooting to see which change it is
that causes the hang.  That will give you a better
idea of which part of the kernel you need to look at.

Do that, and tell us what make and model of laptop
you are using.

--
Thomas Hood

