Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbSI2U5Y>; Sun, 29 Sep 2002 16:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSI2U5Y>; Sun, 29 Sep 2002 16:57:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3032 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261804AbSI2U5X>; Sun, 29 Sep 2002 16:57:23 -0400
Date: Sun, 29 Sep 2002 23:02:41 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.39-dj1
In-Reply-To: <20020929202416.GA1518@suse.de>
Message-ID: <Pine.NEB.4.44.0209292300340.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

it seems there was a problem when generating the patch, the following
doesn't seem to be intended (and causes compile errors):


--- linux-2.5.39/include/linux/kernel.h 2002-09-27 22:48:34.000000000 +0100
+++ linux-2.5/include/linux/kernel.h    1970-01-01 01:00:00.000000000 +0100
@@ -1,209 +0,0 @@
-#ifndef _LINUX_KERNEL_H
-#define _LINUX_KERNEL_H



cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

