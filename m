Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTLEKSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 05:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTLEKSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 05:18:43 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:37536 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263650AbTLEKSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 05:18:42 -0500
From: Duncan Sands <baldrick@free.fr>
To: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Fri, 5 Dec 2003 11:18:37 +0100
User-Agent: KMail/1.5.4
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org
References: <3FC4E8C8.4070902@free.fr> <200312050838.58349.baldrick@free.fr> <3FD059BD.1090704@free.fr>
In-Reply-To: <3FD059BD.1090704@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312051118.37232.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That explains why this relatively harmless Oops was
> > freezing Vince's box.  I guess he should turn it off.
>
> Well, I don't find this oops harmless at all : my box is usually
> freezing while in a huge of other oopses that directly follow this one,
> and then nothing makes it into the logs. I had to set this sysctl once
> in order to get the first oops, but that's not related to the other
> freeze...

What is the second Oops?

Thanks,

Duncan.
