Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269126AbRHEAkX>; Sat, 4 Aug 2001 20:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269882AbRHEAkN>; Sat, 4 Aug 2001 20:40:13 -0400
Received: from adsl-64-164-130-2.dsl.snfc21.pacbell.net ([64.164.130.2]:16370
	"EHLO baddog.localdomain") by vger.kernel.org with ESMTP
	id <S269126AbRHEAj7>; Sat, 4 Aug 2001 20:39:59 -0400
Date: Sat, 4 Aug 2001 17:39:17 -0700 (PDT)
From: <rich+ml@lclogic.com>
To: <linux-kernel@vger.kernel.org>
Subject: module unresolved symbols
Message-ID: <Pine.LNX.4.30.0108041726050.8186-100000@baddog.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, kindly redirect me if this is the wrong list.

Starting with a stock RH 7.0 install, I changed a single kernel config
item and recompiled with 'make defs clean bzImage modules
modules_install'.

Booted on the new kernel and depmod complains that dozens of modules
contain unresolved symbols. Back to the original kernel, now it also
complains of unresolved symbols (not the same set of modules, and modules
that were previously OK).

I can't find an answer on the net, does anyone know how to fix this?

Thanks == Rich

