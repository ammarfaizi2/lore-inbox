Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVKBNtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVKBNtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVKBNtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:49:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36559 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965045AbVKBNtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:49:20 -0500
Date: Wed, 2 Nov 2005 14:48:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthew Wilcox <matthew@wil.cx>
cc: Adrian Bunk <bunk@stusta.de>, grundler@parisc-linux.org,
       linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [2.6 patch] parisc: "extern inline" -> "static
 inline"
In-Reply-To: <20051030152215.GB9235@parisc-linux.org>
Message-ID: <Pine.LNX.4.61.0511021448010.8013@yvahk01.tjqt.qr>
References: <20051030000301.GO4180@stusta.de> <20051030152215.GB9235@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> "extern inline" doesn't make much sense.

But GNU's ld is said to be smart enough to handle this like the 
developerwants "extern AND inline". I did not try, though.


Jen

