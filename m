Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbULaSbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbULaSbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 13:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbULaSbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 13:31:09 -0500
Received: from news.cistron.nl ([62.216.30.38]:28124 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261727AbULaSbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 13:31:08 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: the umount() saga for regular linux desktop users
Date: Fri, 31 Dec 2004 18:31:07 +0000 (UTC)
Organization: Cistron Group
Message-ID: <cr45tb$4l5$1@news.cistron.nl>
References: <200412311741.02864.wh@designed4u.net> <2b8348ba041231094816d02456@mail.gmail.com> <200412311322.14359.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1104517867 4773 62.216.29.200 (31 Dec 2004 18:31:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200412311322.14359.gene.heskett@verizon.net>,
Gene Heskett  <gene.heskett@verizon.net> wrote:
>Let me toss this out for discussion.
>
>There are some times when the usual 5 second flush schedule should be 
>tossed out the window, and the data written immediately.  A quickly 
>unpluggable usb memory dongle is a prime candidate to bite the user 
>precisely where it hurts.  Floppies also fit this same scenario, I 
>don't know at the times I've written an image with dd, got up out of 
>my chair and went to the machine and slapped the eject button to 
>discover to my horror, that when my hand came away from the button 
>with disk in hand, the frigging access led was now on that wasn't 
>when I tapped the button.

Google for "supermount".

Mike.

