Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWHZSwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWHZSwI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 14:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWHZSwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 14:52:08 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:17106 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S932337AbWHZSwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 14:52:05 -0400
In-Reply-To: <20060826155905.GC2900@elf.ucw.cz>
References: <20060826155905.GC2900@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29339CE5-A279-411F-9637-5E15E2DCD5C8@kernel.crashing.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: strange usb device in thinkpad x60: 17ef:1000
Date: Sat, 26 Aug 2006 20:51:57 +0200
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...any ideas what it is?

17ef is Lenovo.  The device is a USB hub AFAICT?


Segher

