Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbUC3O6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUC3O6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:58:32 -0500
Received: from members.dynaloop.net ([217.172.172.238]:27874 "EHLO
	mail.dynaloop.net") by vger.kernel.org with ESMTP id S263697AbUC3O5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:57:36 -0500
Subject: Mounting Reiserfs partition fails on 2.6.4 and higher
From: Harald Glatt <hachre@dynaloop.net>
To: linux-kernel@vger.kernel.org
Message-Id: <1080658655.4029.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 16:57:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I am currently running Gentoo Linux with Kernel 2.6.3.
Everything is running fine.

When I try to update the kernel to 2.6.4 or higher the Gentoo init
script hangs at "Remounting root partition read/write".
After a while waiting I get some horrible output...

I have a description of my problem with more info, a photo of the kernel
messages and my kernel config at:
http://www.hachre.de/dkb/1

I was at IRC (freenode.org) in #kernel and #gentoo, but noone had any
clue how to fix this... Someone in #kernel proposed to post at the lkml,
that's why I am doing this!

I am not (yet) subscribed to the list, so please be so kind and CC
hachre@dynaloop.net at any answermails you might have!

Thank you for your help in advance!
bye
Harald Glatt (hachre)

