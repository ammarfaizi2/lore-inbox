Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRCAF1g>; Thu, 1 Mar 2001 00:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbRCAF1P>; Thu, 1 Mar 2001 00:27:15 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:53706 "HELO
	squeaker.ratbox.org") by vger.kernel.org with SMTP
	id <S129524AbRCAF1N>; Thu, 1 Mar 2001 00:27:13 -0500
Date: Thu, 1 Mar 2001 00:27:10 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: linux-kernel@vger.kernel.org
Subject: Odd error message..
Message-ID: <Pine.LNX.4.21.0103010025500.27615-100000@squeaker.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__alloc_pages: 2-order allocation failed.


I get many of these across the console when testing a network application
that. Basically the client opens up a bunch of connections to the server
and starts firing off data as quickly as it can.  If you need further
information please let me know.

Regards,

Aaron


