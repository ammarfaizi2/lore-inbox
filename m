Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266736AbUGUVU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266736AbUGUVU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUGUVU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:20:26 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:35754 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S266736AbUGUVUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:20:22 -0400
Subject: Re: [PATCH] delete devfs
From: Jesse Stockall <stockall@magma.ca>
To: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040721145208.GA13522@kroah.com>
References: <20040721141524.GA12564@kroah.com>
	 <200407211626.55670.oliver@neukum.org>  <20040721145208.GA13522@kroah.com>
Content-Type: text/plain
Message-Id: <1090444782.8033.4.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Jul 2004 17:19:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 10:52, Greg KH wrote:
> 
> And as Lars points out, the code is unmaintained, unused, and buggy.
> All good reasons to rip out it out at any moment in time.

Unused? Since when does every Linux user use a vendor supplied kernel? I
have no use for devfs, never used it in the past, and I'm a happy udev
user now, but that doesn't change the fact that there are many devfs
users out there.

What does this gain us right now?

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

