Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264435AbTKNUPm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTKNUPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:15:42 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:12038 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264435AbTKNUPl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:15:41 -0500
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Patrick Beard <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
References: <09A92EA4A9D2D51182170004AC96FE7A1216BB@mercury.scotcomms>
	<20031114190337.GA18107@win.tue.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 15 Nov 2003 05:15:26 +0900
In-Reply-To: <20031114190337.GA18107@win.tue.nl>
Message-ID: <87brrer9k1.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> > Yes, with 2.4 I used sda1. When I first compiled 2.6 I used sda1 but I got
> > the 'wrong fs..' error. This was a clean install of debian so I didn't have
> > my original fstab. I checked the web and noticed people using sda. so I
> > tried that - same error. In trying to get this to work I've used sda and
> > sda1 at different times both gave the same errors.
[...]
> Only try sda1, and report whatever goes wrong in that case.

Ah, I see. His error message are...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
