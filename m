Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbUK0RZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUK0RZo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbUK0RX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:23:58 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:57509 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261269AbUK0RWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 12:22:08 -0500
Subject: client socket and source port selection
From: =?ISO-8859-1?Q?jo=EBl?= Winteregg <joel.winteregg@eivd.ch>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1101576123.744.31.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 27 Nov 2004 18:22:03 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

For the project i'm doing, i must know how the Linux kernel allocate
sockets source port (from the dynamic range of the (2**16)-1 ports). I
looked on the Web but it's really hard to find the algoritm of the
source port allocation...

Someone maybe know how it's work or if there is a paper on the web that
explain this source port selection ?

Thanks a lot for your help !


Joël.W

