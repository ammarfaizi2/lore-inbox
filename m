Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRB0SOF>; Tue, 27 Feb 2001 13:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRB0SNp>; Tue, 27 Feb 2001 13:13:45 -0500
Received: from [199.183.24.200] ([199.183.24.200]:62271 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129725AbRB0SNn>; Tue, 27 Feb 2001 13:13:43 -0500
Date: Tue, 27 Feb 2001 13:13:05 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: "Russell C. Hay" <shakes@emorific.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bug Report in pc_keyb
In-Reply-To: <E14XoU0-0003ZY-00@emorific.com>
Message-ID: <Pine.LNX.4.30.0102271312180.9604-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, Russell C. Hay wrote:

> I'm not really sure who to send this too.  Unfortunately, I don't really have
> much information on this bug, and I will provide more when I'm around the box
> in question.  I have linux 2.2.16 running fine on the box.  I am currently
> trying to upgrade to linux 2.4.2.  However, after compiling 2.4.2 and
> installing in lilo and rebooting, I get the following error scrolling on
> my screen

I'm working on a patch for pc_keyb which should hopefully address this
problem.  I'll send a copy to you for testing as soon as it's ready.

		-ben

