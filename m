Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUAYVqn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAYVqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:46:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:8360 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265253AbUAYVql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:46:41 -0500
Date: Sun, 25 Jan 2004 13:46:25 -0800
From: Greg KH <greg@kroah.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Marc Mongenet <Marc.Mongenet@freesurf.ch>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
Message-ID: <20040125214625.GB28000@kroah.com>
References: <4013D155.3080900@freesurf.ch> <87y8rw2eyy.fsf@devron.myhome.or.jp> <40140221.40901@freesurf.ch> <87isiz3luw.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87isiz3luw.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 03:48:55AM +0900, OGAWA Hirofumi wrote:
> Hi,
> 
> Is this known problem? Any idea?

Yes, run 'eject' after removing the media before inserting the new
media.  That should fix the problem.

greg k-h
