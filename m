Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268467AbRGXV3I>; Tue, 24 Jul 2001 17:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268466AbRGXV2t>; Tue, 24 Jul 2001 17:28:49 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:55937 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S268465AbRGXV2o>;
	Tue, 24 Jul 2001 17:28:44 -0400
Message-ID: <3B5DEA6F.86ABFD61@randomlogic.com>
Date: Tue, 24 Jul 2001 14:36:47 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Newbie problem
In-Reply-To: <20010724211726.33706.qmail@web12307.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Frank Akujobi wrote:
> 
> Hi all,
> Am a newbie and this is my first post. I just
> installed Redhat7.1 (one I downloaded) and it's
> working well even hooked it up to the internet. I
> checked my /usr/src/ and I don't find a /linux
> directory. I find only one directory... /redhat. It
> there something wrong somewhere, or do I have to
> download a kernel source seperately. Doing uname -r
> shows me that I have 2.4.x.x.
> 
The kernel sources are not installed by default, you have to select them during install or (if you have the disk space) you can select Custom Installation and
then at the bottom of the package selection screen, click the box tha says Everything.

You can also install the RPMs from the CD.

PGA
