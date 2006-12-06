Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934996AbWLFPZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934996AbWLFPZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935381AbWLFPZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:25:43 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54999 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934996AbWLFPZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:25:36 -0500
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Li Yu <raise.sail@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
In-Reply-To: <Pine.LNX.4.64.0612061615080.29624@jikos.suse.cz>
References: <200612061803324532133@gmail.com>
	 <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
	 <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
	 <1165415924.2756.63.camel@localhost>
	 <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz>
	 <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com>
	 <Pine.LNX.4.64.0612061615080.29624@jikos.suse.cz>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 16:25:56 +0100
Message-Id: <1165418756.2756.81.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

> This would be nice to merge, if noone has any major objections, and do 
> other development on top of that. 
> I am currently trying to set up an account and git tree for this at 
> kernel.org ... request sent, waiting for reply :)

I can setup a tree for the merge. You simply have to create the patches
with cg-mkpatch and then I can apply them.

Regards

Marcel


