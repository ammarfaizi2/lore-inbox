Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933046AbWFZVOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWFZVOf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933050AbWFZVOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:14:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:14523 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S933046AbWFZVOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:14:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [Suspend2][ 00/11 Module support.
Date: Mon, 26 Jun 2006 23:15:29 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606262315.29364.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 18:53, Nigel Cunningham wrote:
> 
> Add utility routines for registering and iterating over modules
> that Suspend2 uses. A suspend2 module is a distinct part of the
> code - the user interface support, storage manager support,
> swapwriter, filewriter and low-level I/O code are all treated
> as separate modules.

Could you please put all of the changes in kernel/power/modules.c into one
patch?  It's quite difficult to review them now, at least for me.

Greetings,
Rafael
