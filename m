Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317040AbSFWPbb>; Sun, 23 Jun 2002 11:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317045AbSFWPbb>; Sun, 23 Jun 2002 11:31:31 -0400
Received: from [62.70.58.70] ([62.70.58.70]:63364 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317040AbSFWPb2>;
	Sun, 23 Jun 2002 11:31:28 -0400
X-Originating-IP: [62.179.172.225]
From: "Roy Sigurd Karlsbakk" <roy@pronto.tv>
To: linux-kernel@vger.kernel.org
Subject: Large block device support?
Date: Sun, 23 Jun 2002 15:31:33 +0000
Message-ID: <20020623.mko.16936000@mail.pronto.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
X-Mailer: phpGroupWare (http://www.phpgroupware.org) v 0.9.13.018
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I just installed a new server running linux (rh73) with 16 IBM 120GB drives
with a 116MB partition per drive - these in RAID-5 + a spare. The result -
1,63TB and then JFS on top on it. It works perfectly.

But - soon, I need to setup a new box where I guess I'll be going for 160gig
drives, due to higher needs, giving me a theoretical total of 2,24TB.

Will it soon be possible to create >2TB block devices on Linux, or is this a
low-priority concern?

thanks

roy
--
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.


