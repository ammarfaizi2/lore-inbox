Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUAIMcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 07:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUAIMcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 07:32:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261411AbUAIMcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 07:32:21 -0500
Date: Fri, 9 Jan 2004 07:33:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: What is codaauth? Why is Linux polling it?
Message-ID: <Pine.LNX.4.53.0401082135560.1311@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a RH System at home, no mods, right out of the box.
It keeps sending UDP packets to 63.240.115.23.codaauth, so fast
it's killing my PPP bandwidth.

Anybody know how to shut it up? There is no coda file-system on
that machine (that I know of).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

