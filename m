Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313297AbSDJQVf>; Wed, 10 Apr 2002 12:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313309AbSDJQVe>; Wed, 10 Apr 2002 12:21:34 -0400
Received: from mail-01.med.umich.edu ([141.214.93.149]:56764 "EHLO
	mail-01.med.umich.edu") by vger.kernel.org with ESMTP
	id <S313297AbSDJQVe> convert rfc822-to-8bit; Wed, 10 Apr 2002 12:21:34 -0400
Message-Id: <scb42e4b.036@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Wed, 10 Apr 2002 12:21:03 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <aab@cichlid.com>, <dang@fprintf.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Tyan S2462 reboot problems
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What display adapter are you using? BIOS's earlier than 1.04 screwed up royally with ATI Radeon 8500/7500 cards - actually, so does 1.04, but not as much. I've also noticed that Radeon + Adaptec 39160 corrupts video where without the Adaptec it doesn't. Strange.

Nik

(This is on the 2460, not 2462)

>>> Daniel Gryniewicz <dang@fprintf.net> 04/09/02 04:14PM >>>
> Hi.

> No, I doubt this has anything to do with Linux.   I have a S2460 (which his
> corrected post says he has), which does not power down under linux, and
> *never* warm boots cleanly.  It does power down under windows, so I assume
> ACPI powerdown works and APM does not.  I have gone under the assumption that
> a BIOS upgrade will fix this, but that involves putting a floppy into the box,
> so I haven't done it yet.  The warm boot problems consist of either a hang
> after POST (but before bootloader, OS irrelevent), or really bad video
> corruption.  I don't know if it boot with the video corruption, I've never let
> it try.

> Daniel


