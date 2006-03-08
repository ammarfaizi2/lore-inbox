Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWCHOeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWCHOeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCHOeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:34:09 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:43906 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751154AbWCHOeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:34:08 -0500
Date: Wed, 8 Mar 2006 15:34:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Mares <mj@ucw.cz>
cc: Anshuman Gholap <anshu.pg@gmail.com>, linux-kernel@vger.kernel.org,
       Jan Knutar <jk-lkml@sci.fi>
Subject: Re: [future of drivers?] a proposal for binary drivers.
In-Reply-To: <mj+md-20060308.102141.5604.albireo@ucw.cz>
Message-ID: <Pine.LNX.4.61.0603081531330.21158@yvahk01.tjqt.qr>
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
 <200603081151.33349.jk-lkml@sci.fi> <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
 <mj+md-20060308.102141.5604.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-949154908-1141828443=:21158"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-949154908-1141828443=:21158
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>
>"Binary drivers will make all devices just work" is a dream. Maybe a nice
>one, but just a dream. It seldom works this way in Windows (almost every
>time you run into some minor, but annoying bug noone is willing to fix),
>why should it work with Linux?
>

It's (should be: it was) worse than that. Under Win98 (Common Platform For
Binary Drivers), you had to install a usbdisk driver for every usb product
class, i.e. Samsung only provides a mass storage driver for Samsung, SONY only
for SONY drives, etc. Luckily this is a little relieved in Win2000 (CPFBD too)
where there is a generic usbdisk driver à la usb_storage.ko, which reads 
more than just from one vendor.


Jan Engelhardt
-- 
--1283855629-949154908-1141828443=:21158--
