Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVBQVNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVBQVNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 16:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVBQVNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 16:13:13 -0500
Received: from alog0416.analogic.com ([208.224.222.192]:18816 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261198AbVBQVNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 16:13:11 -0500
Date: Thu, 17 Feb 2005 16:12:32 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: "Needlessly global functions static...."
Message-ID: <Pine.LNX.4.61.0502171607500.18275@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
Tell me. When all those kernel functions are made static
how does one use a kernel debugger? How does the OOPS
get decoded if nothing is in /proc/kallsyms or System.map???

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
