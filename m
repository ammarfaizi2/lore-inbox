Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbTJYKTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 06:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbTJYKTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 06:19:19 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:29706 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262554AbTJYKTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 06:19:10 -0400
To: Vid Strpic <vms@bofhlet.net>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: *FAT problem in 2.6.0-test8
References: <20031024103225.GC1046@home.bofhlet.net>
	<20031024185953.GA9265@win.tue.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 25 Oct 2003 19:18:03 +0900
In-Reply-To: <20031024185953.GA9265@win.tue.nl>
Message-ID: <87ismdoc2s.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> On Fri, Oct 24, 2003 at 12:32:26PM +0200, Vid Strpic wrote:
> 
> > Yesterday, I just wanted to download some pics from a Smartmedia card
> > from my camera.  I put the card into the reader (USB Mass Storage Flash
> > Card Reader, Manufacturer: EZ, Serial Number: 9876543210ABCDEF, driver
> > is usb-storage and working well now, I had problems earlier), but the
> > kernel doesn't recognize FAT filesystem on the card...
> > 
> > Oct 23 17:19:01 moria kernel: FAT: invalid first entry of FAT (0xff8 != 0x0)

[...]

> How was this card formatted?

It looks like it doesn't conform to Microsoft's or SmartMedia's
specifications.

Yes. It will be important to know how it was formated. 
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
