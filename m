Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSHVTDZ>; Thu, 22 Aug 2002 15:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSHVTDZ>; Thu, 22 Aug 2002 15:03:25 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:57261 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315634AbSHVTDY>; Thu, 22 Aug 2002 15:03:24 -0400
Date: Thu, 22 Aug 2002 12:02:22 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: v2.5.31 handle_scancode oops
In-Reply-To: <20020812192858.S1781@redhat.com>
Message-ID: <Pine.LNX.4.33.0208221202010.9077-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When booting with only the serial console enabled, pressing Ctrl-Scroll
> Lock kills the system with the following oops.  Whoever has been working
> on the console code might be interested in fixing this.

Fix is in my console BK tree.

