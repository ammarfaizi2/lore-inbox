Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270201AbRIEJhT>; Wed, 5 Sep 2001 05:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270199AbRIEJhI>; Wed, 5 Sep 2001 05:37:08 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:19470 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S270165AbRIEJhA>; Wed, 5 Sep 2001 05:37:00 -0400
Date: Wed, 5 Sep 2001 10:37:19 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: swapping on files on reiserfs safe?
In-Reply-To: <20010827214230.A7866@bug.ucw.cz>
Message-ID: <Pine.LNX.4.33.0109051036470.31789-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 27 Pavel Machek wrote:

>Is it safe to swap onto swapfile located on reiserfs?

Don't know if it's safe, but I'm doing it and it seems to be OK :)

