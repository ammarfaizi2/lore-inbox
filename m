Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319413AbSILCbr>; Wed, 11 Sep 2002 22:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319414AbSILCbr>; Wed, 11 Sep 2002 22:31:47 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:62453 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S319413AbSILCbq>; Wed, 11 Sep 2002 22:31:46 -0400
Subject: PCI: device 00:00.0 has unknown header type 7f, ignoring.
From: Nicholas Miell <nmiell@attbi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 19:36:28 -0700
Message-Id: <1031798190.1499.8.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting this message since, oh, the dawn of time or so.
I finally worked up enough curiosity to attempt to figure out what the
mysterious 7f header is, but the PCI specs require money.

So, anyone out there happen to know what header 7f is, and why the
kernel doesn't recognize it?
 
- Nicholas

