Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSGCXqJ>; Wed, 3 Jul 2002 19:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317280AbSGCXqI>; Wed, 3 Jul 2002 19:46:08 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:40205 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317279AbSGCXqF>; Wed, 3 Jul 2002 19:46:05 -0400
Date: Thu, 4 Jul 2002 01:48:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries Brouwer <aebr@win.tue.nl>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: hd_geometry question.
In-Reply-To: <20020703002039.GA22020@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0207040144500.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Jul 2002, Andries Brouwer wrote:

> It is rumoured that certain MO disks with a hardware sector size
> of 2048 bytes have partition tables in units of 2048-byte sectors.

Why is it a rumour? AFAIK under DOS/Windows the partition table is in
units of sector size.

bye, Roman

