Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTATRUZ>; Mon, 20 Jan 2003 12:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTATRUZ>; Mon, 20 Jan 2003 12:20:25 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:10909 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S266285AbTATRUZ>; Mon, 20 Jan 2003 12:20:25 -0500
Date: Mon, 20 Jan 2003 18:29:25 +0100 (CET)
From: <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: tool for testing how fast your kernel can rename files :-)
Message-ID: <Pine.LNX.4.33.0301201826120.13207-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This night, while half a-sleep I thought it is usefull to have a tool
which creates a number of files in a directory and then starts to randomly
rename them. During this, it should output how much it has done and how
many renames per second it did.
5 minutes back I programmed such a program, you can download it from:
http://www.vanheusden.com/Linux/rename_test-1.0.tgz

But now, fully awake with at least 8 cups of coffee in my system I cannot
think of anything usefull this program is actually doing.
Well, maybe to test if something gets corrupted allong the way?

Oh well.


Folkert van Heusden
www.vanheusden.com

