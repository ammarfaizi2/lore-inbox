Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269831AbRHSBkS>; Sat, 18 Aug 2001 21:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269848AbRHSBkH>; Sat, 18 Aug 2001 21:40:07 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:7845 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269837AbRHSBkF>; Sat, 18 Aug 2001 21:40:05 -0400
Date: Sat, 18 Aug 2001 21:40:18 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108190140.f7J1eIB26553@devserv.devel.redhat.com>
To: alex.buell@tahallah.demon.co.uk
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 'make dep' produces lots of errors with this .config
In-Reply-To: <mailman.998089981.28957.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.998089981.28957.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sparc32 doesn't use PCI at all, unless there's something I don't know.

We support JavaStaion-NC, JavaStation-E, Serengeti SGSC, and
Sun CP-1200 - basically everything sparc32 with PCI is supported
(except Sun Ray).

-- Pete
