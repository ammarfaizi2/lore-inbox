Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282693AbRLGP4n>; Fri, 7 Dec 2001 10:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282843AbRLGP4d>; Fri, 7 Dec 2001 10:56:33 -0500
Received: from sushi.toad.net ([162.33.130.105]:25515 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S282693AbRLGP4V>;
	Fri, 7 Dec 2001 10:56:21 -0500
Subject: Re: IDE hotswap still broken in 2.4.17pre2...
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 10:57:16 -0500
Message-Id: <1007740637.2034.4.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has never worked for me when I have tried it.

Attempts to "hdparm -R" and "hdparm -U" repeatedly
always eventually crash the kernel ... sometimes after
three or four iterations.



