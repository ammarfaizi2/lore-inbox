Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317795AbSGKJAU>; Thu, 11 Jul 2002 05:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317797AbSGKJAT>; Thu, 11 Jul 2002 05:00:19 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:20176 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317795AbSGKJAT>; Thu, 11 Jul 2002 05:00:19 -0400
Date: Thu, 11 Jul 2002 11:21:06 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: =?iso-8859-1?q?Henning=20Petersen?= <castrolmanden2@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: unhandled interrupt: 0xff63fc7f crash with emu10k1/soundblaster
 live value card
In-Reply-To: <20020711081024.58052.qmail@web20414.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0207111111280.2430-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, Henning Petersen wrote:

> > nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2802  Tue Mar  5
> > 06:26:45 PST 2002

Did your older computer also use the nvdriver? Can you reproduce this 
using the opensource XFree86 nv driver? You can also try shuffling PCI 
cards around or changing BIOS settings so that your sound card and video 
card don't share interrupts (check /proc/interrupts)

Cheers,
	Zwane

-- 
function.linuxpower.ca


