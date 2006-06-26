Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933050AbWFZVTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050AbWFZVTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933052AbWFZVTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:19:10 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17083 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S933050AbWFZVTJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:19:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Mon, 26 Jun 2006 23:20:01 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606262320.01535.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 18:54, Nigel Cunningham wrote:
> 
> Add Suspend2 extent support. Extents are used for storing the lists
> of blocks to which the image will be written, and are stored in the
> image header for use at resume time.

Could you please put all of the changes in kernel/power/extents.c into one
patch?  It's quite difficult to review them now, at least for me.

Well, I think similar remarks will apply to the other series of patches too, so
I won't repeat them if you don't mind.  [Also I won't be able to have a look
at the other patches today.  I'll do my best to review them in the next couple
of days.]

Greetings,
Rafael
