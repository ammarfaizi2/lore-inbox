Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSKSNyf>; Tue, 19 Nov 2002 08:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSKSNye>; Tue, 19 Nov 2002 08:54:34 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:31958 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265306AbSKSNyb>; Tue, 19 Nov 2002 08:54:31 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 19 Nov 2002 06:01:26 -0800
Message-Id: <200211191401.GAA11326@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Patch: module-init-tools-0.6/modprobe.c - support subdirectories
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor self-correction.  Regarding using modules.dep, I wrote:
>[...] you might like to consider that this change could reduce or
>completely eliminate all references to ELF in modprobe and insmod.
                                            ^^^^^^^^^^^^^^^^^^^^^^

That should just read "in modprobe."

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
